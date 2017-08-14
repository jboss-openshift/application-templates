# Application Templates
This project contains OpenShift v3 application templates which support
Red Hat SSO/Keycloak

## Structure
Several templates are provided:
 * sso70-https.json:  SSO/Keycloak template backed by internal H2 database
 * sso70-postgresql.json: SSO/Keycloak template backed by Postgresql
 * sso70-postgresql-persistent.json: SSO/Keycloak template backed by persistent Postgresql
 * sso70-mysql.json: SSO/Keycloak template backed by MySQL
 * sso70-mysql-persistent.json: SSO/Keycloak template backed by persistent MySQL

Templates are configured with the following basic parameters:
 * APPLICATION_NAME: the name of the application (defaults to sso)
 * HTTPS_SECRET: Name of the Secret to use to expose SSO/Keycloak over HTTPS (defaults to sso-app-secret)
 * HTTPS_KEYSTORE: Name of the keystore to use to expose SSO/Keycloak over HTTPS (defaults to keystore.jks)
 * HTTPS_NAME: The alias of the keys/certificate to use to expose SSO/Keycloak over HTTPS (required)
 * HTTPS_PASSWORD: The password of the keystore to use to expose SSO/Keycloak over HTTPS (required)
 * SSO_ADMIN_USERNAME: The username of the initial admin user in the Master Realm (defaults to admin)
 * SSO_ADMIN__PASSWORD: The password of the initial admin user in the Master Realm (defaults to admin)
 * SSO_REALM: Realm that will be automatically created (optional)
 * SSO_SERVICE_USERNAME: User that will be automatically created in SSO_REALM with permissions to create client configrations (optional)
 * SSO_SERVICE_PASSWORD: Password for SSO_SERVICE_USERNAME (optional)

## Username/Password
For SSO Server: Defaults to admin/admin but can be overridden by SSO_ADMIN_USERNAME/SSO_ADMIN_PASSWORD

## SSO Example

Create Secrets and SSO/Keycloak Server in user (e.g. "myproject") project/namespace:

```
$ oc create -n myproject -f ../secrets/sso-app-secret.json
$ oc process -f sso70-postgresql.json -v HTTPS_NAME=jboss,HTTPS_PASSWORD=mykeystorepass | oc create -n myproject -f -
```

After executing the above, you should be able to access the SSO/Keycloak server at http://sso-myproject.hostname/auth and https://secure-sso-myproject.hostname/auth

