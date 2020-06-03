.ONESHELL:
SHELL=bash

# export CONFIG_SHA1=$(shell sha1sum config.yaml)
# export PROVIDERS_SHA1=$(shell sha1sum config.yaml)

up:
	#eval $(weave env) # use https://www.weave.works/docs/net/latest/tasks/weave-docker-api/using-proxy/
	docker-compose up -d --build

down:
	docker-compose down

install:
	backup-timers/install.sh

upgrade:
	echo "NOt YET IMPL" >& 2
	exit 1
	echo "traefik: replace version manually"

####################################

# testmail:
# 	gitlab-rails console:   Notify.test_email('gernot.eger@gmail.com', 'Testmail from gitlab', 'A test.').deliver_now
# 	gitlab-rails console:   Notify.test_email('gernot@eger.cc', 'Testmail from gitlab', 'A test.').deliver_now

testmail:
	echo "Notify.test_email('gernot.eger@gmail.com', 'Testmail from gitlab', 'A test.').deliver_now\n" | \
		docker-compose exec -T gitlab gitlab-rails console

rails-console:
	docker-compose exec gitlab gitlab-rails console

backup1:
	./create-backup.sh

backup:
	systemctl start gitlab-backup.service
	journalctl -u gitlab-backup --no-pager

build:	
	docker-compose build

restart: down up

logs:
	docker-compose logs -f || echo "done."

bash:
	docker-compose exec gitlab bash

test:
	curl -L https://git.eger.cc/