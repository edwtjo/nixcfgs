{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.tjonix.nginx;

in

{

  options.tjonix.nginx = {
    enable = mkEnableOption "Use tjonix nginx overlay configuration";
    vhosts = mkOption {
      default = {};
      type = with types; loaOf optionSet;
      options = [ ({ name, config, ... }: {
        options = {
	  enable = mkEnableOption "Enable this vhost";
	  hostName = mkOption {
	    default = "localhost";
	    type = types.str;
	  };
          config = mkOption {
	    default = "";
	    type = types.str;
	  };
	};
	config = { hostName = mkDefault name; };
      })];
    };
  };
  
  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      httpConfig = ''
        fastcgi_cache_path /var/cache/nginx levels=1:2 keys_zone=code:10m inactive=1h max_size=100m;
   
        log_format main
                '$remote_addr - $remote_user [$time_local] '
                '"$request" $status $bytes_sent '
                '"$http_referer" "$http_user_agent" '
                '"$gzip_ratio"';
   
        error_log /var/log/nginx/errors.log;
	access_log /var/log/nginx/access.log;
        connection_pool_size 256;
        client_header_buffer_size 1k;
        large_client_header_buffers 4 2k;
        request_pool_size 4k;
   
        output_buffers 1 32k;
        postpone_output 1460;
   
        server_tokens off;
        ignore_invalid_headers on;
   
        client_header_timeout 5;
        client_body_timeout 15;
        send_timeout 10;
        keepalive_timeout 20 15;
   
        gzip on;
        gzip_vary on;
        gzip_comp_level 9;
        gzip_min_length 1100;
        gzip_buffers 16 8k;
        gzip_types text/plain text/css image/bmp;
   
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
   
        index index.html;

        uwsgi_param  QUERY_STRING       $query_string;
        uwsgi_param  REQUEST_METHOD     $request_method;
        uwsgi_param  CONTENT_TYPE       $content_type;
        uwsgi_param  CONTENT_LENGTH     $content_length;
        
        uwsgi_param  REQUEST_URI        $request_uri;
        uwsgi_param  PATH_INFO          $document_uri;
        uwsgi_param  DOCUMENT_ROOT      $document_root;
        uwsgi_param  SERVER_PROTOCOL    $server_protocol;
        uwsgi_param  HTTPS              $https if_not_empty;
        
        uwsgi_param  REMOTE_ADDR        $remote_addr;
        uwsgi_param  REMOTE_PORT        $remote_port;
        uwsgi_param  SERVER_PORT        $server_port;
        uwsgi_param  SERVER_NAME        $server_name;
        ${flip concatMapStrings (filter (vhost: vhost.enable == true) (attrValues cfg.vhosts)) (vhost: ''
          server {
            server_name     ${vhost.hostName};
            ${vhost.config}
          }
        '')}
      '';
    }; 
  };
}