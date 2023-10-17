# SearchStax - Drupal Demo Site Install

## Session Links

- [Attendee Survey](https://forms.gle/vXpQWTvPVMM8tk356)
- [SearchStax Studio Account Sign Up](https://searchstudio.searchstax.com/freetrial)

## Drupal Dev Environment Prerequisites

You'll need the following software and packages installed to get started
- Docker
- npm
- make (Windows - `choco install make`)


### Docker - Installing the Demo Environment

- Install Docker
- Switch to Linux containers if you're using Windows
- Run `make setup-drupal`
- Navigate to [`http://localhost:8088`](http://localhost:8088) to access the Drupal install
- Navigate to [`http://localhost:8080`](http://localhost:8080) to access the Vue search app

## Configuring your Drupal Demo Site

- If everything above is installed correctly open [`http://localhost:8088/users/login`](http://localhost:8088/users/login) (this should happen automatically after successful install)
- User name is `admin` and the default password is `searchstax`

## Create a SearchStax account

- Sign up for a [SearchStax Studio account](https://searchstudio.searchstax.com/freetrial)
- Confirm your email and login
- Create a new index

## Adding a SearchStax Index

- Go to [*Configuration*](http://localhost:8088/en/admin/config/search/search-api) and select *Search API*
- Add a server name
- Select `SearchStax Cloud with Token Auth` in the *Configure Solr backend* panel
- Paste the update endpoint URL and write token

## Creating a Drupal module

You can use our prebuilt Search UI App or build your own custom Vue search result page.

### Prebuilt Search UI App

- Log into your SearchStax Studio account and go to the `Search UI` panel
- Click *View* to open the prebuilt app
- View the page source code and copy everything
- Paste the copied source code into `searchstudio-searchjs/templates/searchstudio.html.twig`
- Zip the `searchstudio-searchjs` directory
- Upload the Zip file in the Drupal Extend admin panel
- Enable the `SearchStax Studio Theme`
- Navigate to [`http://localhost:8088/searchstudio`](http://localhost:8088/searchstudio)

### Building the Vue Search Page

Once you've created a SearchStax Studio account you can add the appropriate access tokens and API endpoints to your Vue app. Open `drupal-vue/src/config.js` and replace the demo site credentials with yours.

Make any updates to the Vue app and test in the Vue development environment ([`http://localhost:8080`](http://localhost:8080)).

#### Live Drupal Environment

- Configure `drupal-vue` app
- Run `make build-search-page` (or `make build-search-page-windows` for Windows)
- Navigate to [`http://localhost:8088/searchstax-studio-vue`](http://localhost:8088/searchstax-studio-vue)

#### Export to Module

- Configure `drupal-vue` app
- Run `make export-search-page` (or `make export-search-page-windows` for Windows)
- Windows users will need to zip the module before uploading
- Upload Zip file in Drupal Extend panel