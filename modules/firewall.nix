{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.tjonix.firewall;
  vpns = attrValues cfg.vpns;

in

{

  options = {

    tjonix.firewall = {

      enable = mkEnableOption "Firewall addendum";

      interface = {
        wan = mkOption {
          default = "enp2s0f0";
        };

        lan = mkOption {
          default = "br0";
        };
      };

      transparentProxy = mkOption {
        default = true;
        type = types.bool;
      };

      naziJail = mkOption {
        default = false;
        type = types.bool;
      };

      privateV4Ips = mkOption {
        default = [
          "127.0.0.0/8"
          "192.168.0.0/16"
          "172.16.0.0/12"
          "10.0.0.0/8"
          "100.64.0.0/10"
          "169.254.0.0/16"
        ];
        type = with types; listOf string;
      };

      privateV6Ips = mkOption {
        default = [ "fe80::/10" ];
        type = with types; listOf string;
      };

      forwards = mkOption {
        default = {};
        type = with types; loaOf optionSet;
        options = [ ({ name, config, ... }: {
          options = {
            host = mkOption {
              type = types.str;
            };
            ports = mkOption {
              default = [];
              type = with types; listOf int;
            };
          };
          config = {
            host = mkDefault name;
          };
        }) ];
      };

      vpns = mkOption {
        default = {};
        type = with types; loaOf optionSet;
        options = [ ({ name, config, ... }: {
          options = {

            provider = mkOption {
              type = types.str;
            };

            interface = mkOption {
              default = null;
              type = with types; nullOr string;
            };

            localIp = mkOption {
              default = null;
              type = with types; nullOr string;
            };

            ports = mkOption {
              default = [];
              type = with types; listOf int;
            };

            mark = mkOption {
              default = null;
              type = with types; nullOr int;
            };

            markedUsers = mkOption {
              default = [];
              type = with types; listOf str;
            };

            markedGroups = mkOption {
              default = [];
              type = with types; listOf str;
            };
          };

          config = {
            provider = mkDefault name;
          };

        }) ];
      };
    };
  };

  config = mkIf cfg.enable {

    boot.kernel.sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
      "net.ipv4.conf.default.forwarding" = true;
      "net.ipv6.conf.all.forwarding" = true;
      "net.ipv6.conf.default.forwarding" = true;
    };

    networking.firewall = {
      enable = true;
      rejectPackets = true;
      allowPing = true;
      logRefusedConnections = false;
      extraPackages = with pkgs; [ ipset iproute ];
      extraCommands = mkMerge [
        (mkOrder 1 ''
          #ip addr add 172.27.72.60/32 dev lo label lo:0
          # ip rule add from 172.27.72.60/32 table mullvad
          echo 2 > /proc/sys/net/ipv4/conf/all/rp_filter
          echo 1 > /proc/sys/net/ipv4/conf/all/route_localnet

          # Default Policy
          ip46tables -P INPUT DROP
          ip46tables -P FORWARD DROP
          ip46tables -P OUTPUT DROP
          # Flush Old Rules
          ip46tables -F INPUT
          ip46tables -F OUTPUT
          ip46tables -F FORWARD
          ip46tables -t nat -F
          ip46tables -t nat -X
          ip46tables -t mangle -F
          ip46tables -t mangle -X

          # Remove old ipsets
          ipset destroy || true

          # Create an ipset for private ip4 addresses
          ipset create lan hash:net family inet
          ${flip concatMapStrings cfg.privateV4Ips (i: ''
            ipset add lan "${i}"
          '')}

          ipset create lan6 hash:net family inet6
          ${flip concatMapStrings cfg.privateV6Ips (i: ''
            ipset add lan6 "${i}"
          '')}

          # Allow everything on loopback
          iptables -A INPUT -i lo -j ACCEPT
          iptables -A OUTPUT -o lo -j ACCEPT

          # Allow local ips
          iptables -A INPUT -t filter -m set --match-set lan src -j ACCEPT
          ip6tables -A INPUT -t filter -m set --match-set lan6 src -j ACCEPT
          iptables -A OUTPUT -t filter -m set --match-set lan src -j ACCEPT
          ip6tables -A OUTPUT -t filter -m set --match-set lan6 src -j ACCEPT

          # Allow forwarding between lan-side networks
          iptables -A FORWARD -t filter -m set --match-set lan src,dst -j ACCEPT
          ip6tables -A FORWARD -t filter -m set --match-set lan6 src,dst -j ACCEPT

          # Allow Established Connnections
          ip46tables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
          ip46tables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

          # Allow root to make local connections
          ip46tables -A OUTPUT -m owner --uid-owner root -j ACCEPT

          # Allow ping
          iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
          ip6tables -A OUTPUT -p icmpv6 --icmpv6-type echo-request -j ACCEPT

          # Allow ssh
          ip46tables -A OUTPUT -p tcp --dport 22 -j ACCEPT

          # Maybe transparent proxy
          ${if (cfg.transparentProxy && config.services.privoxy.enable) then ''
          iptables -t nat -A PREROUTING -m set --match-set lan src -p tcp --dport 80 -j REDIRECT --to-port 8118
          ip6tables -t nat -A PREROUTING -m set --match-set lan6 src -p tcp --dport 80 -j REDIRECT --to-port 8118
          '' else ''
          ''}

          # Maybe block all web traffic not going through the proxy
          ${if cfg.naziJail then ''
          iptables -A FORWARD -m set --match-set lan src -p tcp -m multiport --dports 80,443 -j REJECT
          ip6tables -A FORWARD -m set --match-set lan6 src -p tcp -m multiport --dports 80,443 -j REJECT
          '' else ''
          ''}

          # VPN exiting should be masqued
          ${flip concatMapStrings
            (collect (vpn: vpn ? interface) cfg.vpns)
            (vpn: ''
             iptables -A POSTROUTING -t nat -o ${vpn.interface} -j MASQUERADE
            '')
          }

          # Mark VPN packets, also drop marked packets exiting WAN side
          ${flip concatMapStrings
            (collect (vpn: vpn ? interface && vpn ? mark ) cfg.vpns)
            (vpn: let mark = toString vpn.mark; in ''
              iptables -A PREROUTING -t mangle -i ${vpn.interface} -j MARK --set-mark ${mark}
              iptables -A PREROUTING -t mangle -i ${vpn.interface} -j CONNMARK --save-mark
              iptables -A PREROUTING -t mangle -j CONNMARK --restore-mark
              iptables -A POSTROUTING -t mangle -m mark --mark ${mark} -o ${cfg.interface.wan} -j DROP
              # Also mark users
              ${concatMapStrings (usr: ''
              iptables -A OUTPUT -t mangle -m owner --uid-owner ${usr} -j MARK --set-mark ${mark}
              ''
              ) vpn.markedUsers}
              # Also mark groups
              ${concatMapStrings (grp: ''
              iptables -A OUTPUT -t mangle -m owner --gid-owner ${grp} -j MARK --set-mark ${mark}
              ''
              ) vpn.markedGroups}
            '')
          }

          # Forward VPN designated ports to local endpoint
          ${flip concatMapStrings
            (collect (vpn: vpn ? interface && vpn ? ports && vpn ? localIp) cfg.vpns)
            (vpn: (concatMapStrings (port: let portS = toString port; in ''
            iptables -t nat -I PREROUTING -i ${vpn.interface} -p tcp --dport ${portS} -j DNAT --to ${vpn.localIp}:${portS}
              iptables -A INPUT -p tcp -i ${vpn.interface} --dport ${portS} -j ACCEPT
              iptables -t nat -I PREROUTING -i ${vpn.interface} -p udp --dport ${portS} -j DNAT --to ${vpn.localIp}:${portS}
              iptables -A INPUT -p udp -i ${vpn.interface} --dport ${portS} -j ACCEPT
            '') vpn.ports))
          }

          # Add forwards
          ${flip concatMapStrings
            (collect (fwd: fwd ? host && fwd ? ports) cfg.forwards)
            (fwd: (concatMapStrings (port: let portS = toString port; in ''
            iptables -t nat -I PREROUTING -p tcp --dport ${portS} -j DNAT --to ${fwd.host}:${portS}
            iptables -A FORWARD -p tcp -d ${fwd.host} --dport ${portS} -j ACCEPT
            '') fwd.ports))
          }

        '')
        (mkAfter ''
          # Allow everything to make external connections
          ip46tables -A OUTPUT -o lo -j REJECT
          iptables -A OUTPUT -m set --match-set lan dst -j REJECT
          ip6tables -A OUTPUT -m set --match-set lan6 dst -j REJECT
          ip46tables -A OUTPUT -j ACCEPT
          ip46tables -A FORWARD -j REJECT
        '')
      ];
      extraStopCommands = mkAfter ''
        # Flush Old Rules
        ip46tables -F INPUT || true
        ip46tables -F OUTPUT || true
        ip46tables -F FORWARD || true
        ip46tables -t nat -F || true
        ip46tables -t nat -X || true
        ip46tables -t mangle -F || true
        ip46tables -t mangle -X || true
        # Undo Default Policy
        ip46tables -P INPUT ACCEPT || true
        ip46tables -P FORWARD ACCEPT || true
        ip46tables -P OUTPUT ACCEPT || true
        # Remove old ipsets
        ipset destroy || true
      '';
    };
  };
}
