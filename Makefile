clear:
	docker-compose down -v

stop:
	docker-compose down

setup-drupal:
	docker-compose up -d
	docker exec drupal composer require drush/drush
	docker exec drupal composer config minimum-stability dev
	docker exec drupal composer config prefer-stable true
	docker exec drupal vendor/bin/drush si demo_umami --db-url=pgsql://drupaluser:drupalpassword@host.docker.internal:5432/drupaldb --site-name="SearchStax Demo" -y
	docker exec drupal vendor/bin/drush cset system.performance css.preprocess false --input-format=yaml -y
	docker exec drupal vendor/bin/drush cset system.performance js.preprocess false --input-format=yaml -y
	docker exec drupal vendor/bin/drush upwd admin "searchstax"
	docker exec drupal vendor/bin/drush pmu search || echo 'Search not installed'
	docker exec drupal composer require drupal/searchstax
	docker exec drupal composer require drupal/search_api_searchstax
	docker exec drupal composer require drupal/search_api_solr
	docker exec drupal vendor/bin/drush en searchstax -y
	docker exec drupal vendor/bin/drush en search_api_searchstax -y
	docker exec drupal chmod -R 777 /opt/drupal/web/sites/default/files
	docker-compose up --build

build-search-page:
	cd drupal-vue; npm install;
	npm run build --prefix 'drupal-vue'
	docker exec drupal vendor/bin/drush pmu searchstax_studio_vue || echo 'SearchStax Studio not installed yet'
	docker exec drupal vendor/bin/drush cr
	cp drupal-vue/dist/index.html searchstax_studio_vue/templates/vue.html.twig
	cp drupal-vue/dist/* searchstax_studio_vue/dist
	docker cp searchstax_studio_vue drupal:/opt/drupal/web/modules
	docker exec drupal vendor/bin/drush en searchstax_studio_vue -y
	echo 'Vue module added to Drupal'

export-search-page:
	echo 'Building Zip'
	cd drupal-vue; npm install;
	npm run build --prefix 'drupal-vue'
	cp drupal-vue/dist/index.html searchstax_studio_vue/templates/vue.html.twig
	cp drupal-vue/dist/* searchstax_studio_vue/dist
	zip -r searchstax_studio_vue_module.zip searchstax_studio_vue
	echo 'Vue module exported'

build-search-page-windows:
	cd drupal-vue && npm install
	npm run build --prefix 'drupal-vue'
	docker exec drupal vendor/bin/drush pmu searchstax_studio_vue || echo 'SearchStax Studio not installed yet'
	docker exec drupal vendor/bin/drush cr
	copy drupal-vue\dist\index.html searchstax_studio_vue\templates\vue.html.twig
	robocopy drupal-vue\dist\* searchstax_studio_vue\dist || echo 'Copied Vue buid into Drupal module'
	docker cp searchstax_studio_vue drupal:/opt/drupal/web/modules
	docker exec drupal vendor/bin/drush en searchstax_studio_vue -y
	echo 'Vue module added to Drupal'

export-search-page-windows:
	echo 'Building Zip'
	-C drupal-vue npm install
	npm run build --prefix 'drupal-vue'
	copy drupal-vue\dist\index.html searchstax_studio_vue\templates\vue.html.twig
	robocopy drupal-vue\dist\* searchstax_studio_vue\dist || echo 'Copied Vue buid into Drupal module'
	echo 'Vue module ready'