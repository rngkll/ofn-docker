#!/bin/bash

service memcached start

# check if setup was completed before
if [ ! -f "/ofn/ofn_setup.lock" ]; then

	touch /ofn/ofn_setup.lock

	rake assets:precompile
	rake db:schema:load

fi

echo "To add demo data run:"
echo "docker exec <container-id> /ofn/demo.sh"

bundle exec unicorn -E production -p 3000 -c ./config/unicorn.rb
