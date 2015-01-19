#!/bin/sh

composer self-update
composer config -g preferred-install source

if [ -n "${MIN_STABILITY:-}" ]; then
	sed -i -e "s/\"minimum-stability\": \"stable\"/\"minimum-stability\": \"${MIN_STABILITY}\"/" composer.json
fi

composer --no-interaction require --no-update satooshi/php-coveralls:~0.6@stable
composer --no-interaction remove --no-update symfony/form symfony/http-kernel symfony/translation symfony/yaml
composer --no-interaction require --no-update --dev sensio/framework-extra-bundle:${SENSIO_FRAMEWORK_EXTRA_BUNDLE_VERSION:-${SYMFONY_VERSION}} symfony/symfony:${SYMFONY_VERSION}
composer --no-interaction update
