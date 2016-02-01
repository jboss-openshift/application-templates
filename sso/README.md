#Application Templates
This project contains OpenShift v3 application templates which support
Red Hat SSO/Keycloak

##Structure
Several templates are provided:
 * sso-image-stream.json: ImageStream for SSO/Keycloak
 * sso-demo.json: Secret containing full SSO/Keycloak configuration used for import. Required for the all-in-one template
 * sso70-postgresql.json: SSO/Keycloak template backed by Postgresql
 * sso70-postgresql-persistent.json: SSO/Keycloak template backed by persistent Postgresql
 * sso70-mysql.json: SSO/Keycloak template backed by MySQL
 * sso70-mysql-persistent.json: SSO/Keycloak template backed by persistent MySQL
 * sso70-postgresql-eap64.json: All-in-one SSO/Keycloak template backed by Postgresql with integrated EAP-based example applications
 * sso70-postgresql-persistent-eap64.json: All-in-one SSO/Keycloak template backed by persistent Postgresql with integrated EAP-based example applications

Templates are configured with the following basic parameters:
 * APPLICATION_NAME: the name of the application (defaults to sso)
 * HTTPS_SECRET: Name of the Secret to use to expose SSO/Keycloak over HTTPS (defaults to sso-app-secret)
 * HTTPS_KEYSTORE: Name of the keystore to use to expose SSO/Keycloak over HTTPS (defaults to keystore.jks)
 * HTTPS_NAME: The alias of the keys/certificate to use to expose SSO/Keycloak over HTTPS (defaults to jboss)
 * HTTPS_PASSWORD: The password of the keystore to use to expose SSO/Keycloak over HTTPS (defaults to mykeystorepass)

##Username/Password
admin/admin


##SSO Example
```
In "openshift" project/namespace:
$ oc create -n myproject -f sso/sso-image-stream.json
$ oc import-image redhat-sso70-openshift

In user project/namespace:
$ oc create -n myproject -f secrets/eap-app-secret.json
$ oc create -n myproject -f secrets/sso-app-secret.json
$ oc process -f sso/sso70-postgresql.json | oc create -f -
```
After executing the above, you should be able to access the SSO/Keycloak server at http://sso-myproject.hostname/auth and https://secure-sso-myproject.hostname/auth

##All-in-One Example
```
In "openshift" project/namespace:
$ oc create -n myproject -f sso/sso-image-stream.json
$ oc import-image redhat-sso70-openshift
$ oc create -n myproject -f ssoeap/ssoeap-image-stream.json
$ oc import-image jboss-ssoeap-openshift

In user project/namespace:
$ oc create -n myproject -f secrets/eap-app-secret.json
$ oc create -n myproject -f secrets/sso-app-secret.json
$ oc process -f sso/sso70-postgresql-eap64.json | oc create -f -
```
After executing the above, you should be able to access the SSO/Keycloak-enabled applications at http://helloworld-myproject.hostname/app-context and https://secure-helloworld-myproject.hostname/app-context

