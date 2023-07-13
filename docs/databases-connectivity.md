# Supported databases

The following table lists the databases supported by EBX:

| Chart value type | Compatible databases                                                                                                                                                                        | Driver included by default |
| :--------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| postgresql       | PostgreSQL 11 or higher / Amazon Aurora PostgreSQL 11.16 (compatible with PostgreSQL 11.16) or higher. / Google Cloud SQL for PostgreSQL 9.6 (compatible with PostgreSQL 9.6.20) or higher. | yes                        |
| sqlserver        | Microsoft SQL Server 2014 or higher                                                                                                                                                         | yes                        |
| h2.standalone    | H2 2.1.212 or higher.                                                                                                                                                                       | yes                        |
| oracle           | Oracle 19c or higher                                                                                                                                                                        | no                         |
| azure.sql        | Microsoft Azure SQL                                                                                                                                                                         | no                         |
| hana             | SAP HANA 2.0 or Higher                                                                                                                                                                      | no                         |

See the EBX product [documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/installation/supported_env.html#databases) for additional information on supported databases.

## Adding JDBC drivers to the image

See [Adding a JDBC driver](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/customizing_the_image.html#_adding_a_new_jdbc_driver) for information on adding a driver that is not included by default in the EBX image.
