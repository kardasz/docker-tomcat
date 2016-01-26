#!/bin/bash
set -e

if [ "$1" = 'catalina.sh' ]; then
    if [ -z "$(getent passwd $RUN_USER)" ]; then
      echo "Creating user $RUN_USER:$RUN_GROUP"

      groupadd --gid ${RUN_GROUP_GID} -r ${RUN_GROUP} && \
      useradd -r --uid ${RUN_USER_UID} -g ${RUN_GROUP} -d /usr/local/tomcat ${RUN_USER}

      chown -R root:root                       ${CATALINA_HOME}/                   \
          && chmod -R 755                      ${CATALINA_HOME}/                   \
          && chmod -R 700                      ${CATALINA_HOME}/logs               \
          && chmod -R 700                      ${CATALINA_HOME}/temp               \
          && chmod -R 700                      ${CATALINA_HOME}/work               \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/logs               \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/temp               \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/work               \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/webapp             \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/webapps            \
          && chown -R ${RUN_USER}:${RUN_GROUP} ${CATALINA_HOME}/conf
    fi

	exec gosu "${RUN_USER}:${RUN_GROUP}" "$@"
fi

exec "$@"