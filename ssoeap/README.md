#Application Templates
This project contains OpenShift v3 application templates which support
Red Hat SSO/Keycloak-enabled applications

##Structure
Several templates are provided:
 * ssoeap-image-stream.json: ImageStream for SSO/Keycloak-enabled EAP
 * ssoeap64-basic-s2i.json: SSO/Keycloak-enabled EAP template

Templates are configured with the following basic parameters in addition to the standard EAP parameters:
 * SSO_URI: URI of the SSO/Keycloak server
 * SSO_REALM: SSO/Keycloak realm for the deployed application(s)
 * SSO_PUBLIC_KEY: Public key of the SSO/Keycloak Realm. This field is optional but if omitted can leave the applications vulnerable to man-in-middle attacks
 * SSO_USERNAME: SSO/Keycloak User required to access the SSO/Keycloak REST API
 * SSO_PASSWORD: Password for SSO_USERNAME
 * SSO_SAML_KEYSTORE_SECRET: Secret to use for access to SAML keystore (defaults to sso-app-secret)
 * SSO_SAML_KEYSTORE: Keystore location for SAML (defaults to /etc/sso-saml-secret-volume/keystore.jks)
 * SSO_SAML_KEYSTORE_PASSWORD=Keystore password for SAML (defaults to mykeystorepass)
 * SSO_SAML_CERTIFICATE_NAME=Alias for keys/certificate to use for SAML (default to jboss)


##Example
Once the SSO/Keycloak server has been instantiated (see sso/README) and configured with the appropriate Realm, Role(s), and User(s) ...

* Create Realm (e.g demo)
* Create Role that corresponds to JEE Role (e.g. user)
* Create User with permanent password credential (e.g. mgmtuser/mgmtpass). Add all "realm-management" Roles. This User is used to automatically configure the SSO Clients in the SSO Server.
* Create User with permanent password credential (e.g. demouser/demopass). Add Roles to User: JEE Role from #2. This User is used to authenticate access to user applications.
 and all "realm-management" Roles

```
Import image-stream(s) into  "openshift" project/namespace from a user with rights to the "openshift" project/namespace:
$ oc create -n openshift -f ssoeap/ssoeap-image-stream.json
$ oc import-image -n openshift jboss-ssoeap64-openshift

Copy the Realm Public Key from the SSO/Keycloak console and use as the value of SSO_PUBLIC_KEY below. Set SSO_URI according to the location of the SSO server.

NOTE: These templates assume a user project/namespace of "demo". If using another project/namespace then APPLICATION_ROUTES ENVs need to be modified accordingly.

Create Secrets and SSO/Keycloak-enabled EAP in user (e.g. "myproject") project/namespace:
$ oc create -n myproject -f secrets/eap-app-secret.json
$ oc create -n myproject -f secrets/sso-app-secret.json
$ oc create -n myproject -f secrets/sso-demo-secret.json
$ oc process -f eap/eap64-sso-s2i.json -v APPLICATION_NAME=helloworld,SOURCE_REPOSITORY_URL=https://github.com/keycloak/keycloak-examples,SOURCE_REPOSITORY_REF=master,CONTEXT_DIR=,SSO_URI=https://secure-sso-demo.hostname/auth,SSO_REALM=demo,SSO_USERNAME=mgmtuser,SSO_PASSWORD=mgmtpass,SSO_PUBLIC_KEY=XXX | oc create -n myproject -f -
```

After executing the above, you should be able to access the SSO/Keycloak-enabled applications at http://helloworld-myproject.hostname/app-context and https://secure-helloworld-myproject.hostname/app-context where app-context is app-jee, app-profile-jee, app-profile-jee-saml, or service depending on the example application. Note the app-html5 and app-profile-html5 example applications are not deployed or functional.

