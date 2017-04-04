FROM max302/storjshare-daemon:latest
LABEL org.freenas.interactive="false"                              \
      org.freenas.version="2.5.1"                                 \
      org.freenas.upgradeable="false"                             \
      org.freenas.expose-ports-at-host="true"                     \
      org.freenas.autostart="true"                                \
      org.freenas.port-mappings="4000:4000/tcp,4001:4001/tcp,4002:4002/tcp,4003:4003/tcp,4004:4004/tcp,4005:40005/tcp"\
      org.freenas.volumes="[						                          \
          {								                                        \
              \"name\":\"/etc/storjshare/config\",				        \
              \"descr\": \"Storj configuration files\"			      \
          },							                                        \
          {								                                        \
              \"name\": \"/etc/storjshare/data\",					        \
              \"descr\": \"Storj data\"		                        \
          },							                                        \
          {								                                        \
              \"name\": \"/etc/storjshare/logs\",					        \
              \"descr\": \"Storj logs\"		                        \
          }	                                                      \
      ]"                                                          \
      org.freenas.settings="[ 						                        \
          {								                                        \
              \"env\": \"TZ\",						                        \
              \"descr\": \"Timezone - eg Europe/London\",		      \
              \"optional\": true					                        \
          }								                                        \
      ]"
