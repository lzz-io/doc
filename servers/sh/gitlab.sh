docker run --detach \
    --hostname git.xgqq.com \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://my.domain.com/'; gitlab_rails['lfs_enabled'] = true;" \
    --publish 443:443 --publish 80:80 --publish 22222:22 \
    --name gitlab \
    --restart always \
    --volume /var/lib/docker/gitlab/config:/etc/gitlab \
    --volume /var/lib/docker/gitlab/logs:/var/log/gitlab \
    --volume /var/lib/docker/gitlab/data:/var/opt/gitlab \
    docker.xgqq.com/gitlab

	
	
root
5iveL!fe
https://docs.gitlab.com/ce/security/reset_root_password.html
	
	
	
ø®‘⁄ redis £¨œ»÷¥––
sudo /opt/gitlab/embedded/bin/runsvdir-start