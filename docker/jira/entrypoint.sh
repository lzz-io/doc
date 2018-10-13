#!/bin/bash
set -e

echo "starting at `date` ..."

if [ "${UID}" -eq 0 ]; then
    # PERMISSIONS_SIGNATURE=$(stat -c "%u:%U:%a" "${JIRA_HOME}")
    # EXPECTED_PERMISSIONS=$(id -u ${RUN_USER}):${RUN_USER}:700
    # if [ "${PERMISSIONS_SIGNATURE}" != "${EXPECTED_PERMISSIONS}" ]; then
    #     chmod -R 700 "${JIRA_HOME}" &&
    #         chown -R "${RUN_USER}:${RUN_GROUP}" "${JIRA_HOME}"
    # fi
    # ${JIRA_INSTALL_DIR}/bin/setenv.sh
    exec su -s /bin/bash "${RUN_USER}" -c "${JIRA_INSTALL_DIR}/bin/start-jira.sh -fg $@"
# else
#     exec "${JIRA_INSTALL_DIR}/bin/start-jira.sh -fg" "$@"
fi

exec "$@"

## 在entrypoint脚本中使用exec
## 不使用exec的话，我们则不能顺利地关闭容器，因为SIGTERM信号会被bash脚本进程吞没。
## exec命令启动的进程可以取代脚本进程，因此所有的信号都会正常工作。