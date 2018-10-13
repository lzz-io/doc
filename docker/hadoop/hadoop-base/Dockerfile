# lzz.io Dockerfile


FROM openjdk

ENV APP_USER=hadoop

# COPY --from=BUILD_TMP /usr/local/bin/gosu /usr/local/bin/

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		openssh-server ; \
	\
	rm -rf /var/lib/apt/lists/*; \
	mkdir -p /var/run/sshd; \
	\
	ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; \
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; \
	chmod 0600 ~/.ssh/authorized_keys; \
	echo 'StrictHostKeyChecking no' >> $HOME/.ssh/config

EXPOSE 22
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["/usr/sbin/sshd", "-D"]
# CMD ["abc"]
