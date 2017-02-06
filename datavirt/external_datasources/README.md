#JDV with Two External Datasources
This example shows how to deploy JDV with 2 external datasources:
 * Postgresql: exposed as an OpenShift Service/Endpoint
 * Oracle: exposed directly

##Structure
 * ose-dba: The source required to build the source/injected image used to add the Oracle driver module, the driver configuration and the datasource definitions (exposed as a Secret)
 * ose-cicd: The template used to deploy JDV
