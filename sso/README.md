# Application Templates
This project contains OpenShift v3 application templates which support Red Hat Single Sign-On (RH-SSO) / Keycloak.

## Structure
Several templates are provided:

|     Template Name                      |                       Description                                        |
| ---------------------------------------|------------------------------------------------------------------------- |
| **_sso72-https.json_**                 | RH-SSO 7.2/Keycloak template backed by internal H2 database.             |
| **_sso72-x509-https.json_**            | RH-SSO 7.2/Keycloak template with auto-generated HTTPS keystore and      |
|                                        | RH-SSO truststore, backed by internal H2 database. The ASYM\_ENCRYPT     |
|                                        | JGroups protocol is used for encryption of cluster traffic.              |
| **_sso72-postgresql.json_**            | RH-SSO 7.2/Keycloak template backed by ephemeral PostgreSQL database.    |
| **_sso72-postgresql-persistent.json_** | RH-SSO 7.2/Keycloak template backed by persistent PostgreSQL database.   |
| **_sso72-x509-_**                      | RH-SSO 7.2/Keycloak template with auto-generated HTTPS keystore and      |
| **_postgresql-persistent.json_**       | RH-SSO truststore, backed by persistent PostgreSQL database. The         |
|                                        | ASYM\_ENCRYPT JGroups protocol is used for encryption of cluster traffic.|
| **_sso72-mysql.json_**                 | RH-SSO 7.2/Keycloak template backed by ephemeral MySQL database.         |
| **_sso72-mysql-persistent.json_**      | RH-SSO 7.2/Keycloak template backed by persistent MySQL database.        |
| **_sso72-x509-_**                      | RH-SSO 7.2/Keycloak template with auto-generated HTTPS keystore and      |
| **_mysql-persistent.json_**            | RH-SSO truststore, backed by persistent MySQL database. The              |
|                                        | ASYM\_ENCRYPT JGroups protocol is used for encryption of cluster traffic.|


The templates are configured with the following basic parameters:


|     Parameter Name                  |                         Description                                                                                       |
| ------------------------------------|-------------------------------------------------------------------------------------------------------------------------- |
| **_APPLICATION\_NAME_**             | The name of the application. Defaults to _sso_.                                                                           |
| **_HTTPS\_SECRET_**                 | The name of the secret to use to expose RH-SSO/Keycloak over HTTPS. Defaults to _sso-app-secret_.                         |
| **_HTTPS\_KEYSTORE_**               | The name of the keystore to use to expose RH-SSO/Keycloak over HTTPS. Defaults to _keystore.jks_.                         |
| **_HTTPS\_NAME_**                   | The alias of the keys/certificate to use to expose RH-SSO/Keycloak over HTTPS. **Required**.                              |
| **_HTTPS\_PASSWORD_**               | The password of the keystore to use to expose RH-SSO/Keycloak over HTTPS. **Required**.                                   |
| **_SSO\_ADMIN\_USERNAME_**          | The username of the initial administrator account to be created for the _master_ realm. **Required**.                     |
| **_SSO\_ADMIN\_PASSWORD_**          | The password of the initial administrator account to be created for the _master_ realm. **Required**.                     |
| **_SSO\_REALM_**                    | The realm that will be automatically created. _Optional_.                                                                 |
| **_SSO\_SERVICE\_USERNAME_**        | User that will be automatically created in **_SSO\_REALM_** with permissions to create client configrations. _Optional_.  |
| **_SSO\_SERVICE\_PASSWORD_**        | The password for **_SSO\_SERVICE\_USERNAME_**. _Optional_.                                                                |


## Credentials of the RH-SSO Administrator Account

When deploying RH-SSO application template, **_SSO\_ADMIN\_USERNAME_** and **_SSO\_ADMIN\_PASSWORD_** parameters denote the user name and password of the RH-SSO server’s administrator account to be created for the _master_ realm.

**Both of these parameters are required.** If not specified, they are auto generated and displayed as an OpenShift Instructional message when the template is instantiated.

## SSO Example

Create [secrets](https://docs.openshift.com/container-platform/latest/dev_guide/secrets.html) and RH-SSO/Keycloak server in user (e.g. "myproject") project/namespace:

```
$ oc create -n myproject -f ../secrets/sso-app-secret.json
$ oc process -f sso70-postgresql.json -v HTTPS_NAME=jboss,HTTPS_PASSWORD=mykeystorepass | oc create -n myproject -f -
```

After executing the above, you should be able to access the RH-SSO/Keycloak server at http://sso-myproject.hostname/auth and https://secure-sso-myproject.hostname/auth.
