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
For SSO Server: admin/admin
For SSO/Keycloak User created in SSO/Server in All-in-One: demouser/demopass

##SSO Example
```

NOTE: These templates assume a user project/namespace of "demo". If using another project/namespace then the SSO_URI and APPLICATION_ROUTES ENVs need to be modified accordingly.

Import image-stream(s) into  "openshift" project/namespace from a user with rights to the "openshift" project/namespace:
$ oc create -n openshift -f sso/sso-image-stream.json
$ oc import-image -n openshift redhat-sso70-openshift

Create Secrets and SSO/Keycloak Server in user (e.g. "myproject") project/namespace:
$ oc create -n myproject -f secrets/eap-app-secret.json
$ oc create -n myproject -f secrets/sso-app-secret.json
$ oc process -f sso/sso70-postgresql.json | oc create -n myproject -f -
```
After executing the above, you should be able to access the SSO/Keycloak server at http://sso-myproject.hostname/auth and https://secure-sso-myproject.hostname/auth

##All-in-One Example
```

NOTE: These templates assume a user project/namespace of "demo". If using another project/namespace then the SSO_URI and APPLICATION_ROUTES ENVs need to be modified accordingly. 

Import image-stream(s) into  "openshift" project/namespace from a user with rights to the "openshift" project/namespace:
$ oc create -n openshift -f sso/sso-image-stream.json
$ oc import-image -n openshift redhat-sso70-openshift
$ oc create -n openshift -f ssoeap/ssoeap-image-stream.json
$ oc import-image -n openshift jboss-ssoeap64-openshift

Create Secrets, SSO/Keycloak Server, and SSO/Keycloak-enabled EAP in user (e.g. "myproject") project/namespace:
$ oc create -n myproject -f secrets/eap-app-secret.json
$ oc create -n myproject -f secrets/sso-app-secret.json
$ oc create -n myproject -f secrets/sso-demo-secret,json
$ oc process -f sso/sso70-postgresql-eap64.json | oc create -n myproject -f -
```
After executing the above, you should be able to access the SSO/Keycloak-enabled applications at http://helloworld-myproject.hostname/app-context and https://secure-helloworld-myproject.hostname/app-context where app-context is app-jee, app-profile-jee, app-profile-jee-saml, or service depending on the example application. Note the app-html5 and app-profile-html5 example applications are not deployed or functional.

