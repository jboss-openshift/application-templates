#JDV with a file-based, volume-mounted datasource
This example assumes a mounted volume that is supplying a file-based datasource. A resource adapter is configured to expose the data mounted at /var/lib/jdv/data.

##Structure
 * ose-dba: The source required to build the source/injected image used to configure the resource adapter
 * ose-cicd: The template used to deploy JDV
