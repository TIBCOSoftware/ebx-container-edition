# Supported databases

This table display all the ebx supported databases types.

#TODO check 'Compatible databases' section for PostgreSQL with the persistence team

| Chart value type | Compatible databases                                                    | Driver included by default |
|:-----------------|-------------------------------------------------------------------------|----------------------------|
| postgresql       | PostgreSQL / Amazon Aurora PostgreSQL / Google Cloud SQL for PostgreSQL | yes                        |  
| sqlserver        | Microsoft SQL Server                                                    | yes                        |  
| h2.standalone    | H2                                                                      | yes                        |  
| oracle           | Oracle                                                                  | no                         |
| azure.sql        | Microsoft Azure SQL                                                     | no                         |
| hana             | SAP HANA                                                                | no                         |

please see the [documentation](https://docs.tibco.com/pub/ebx/5.9.18/doc/html/en/installation/supported_env.html#databases)
for further information about the supported databases.

### Adding new database JDBC driver in the image  

To add another driver that is not included in the ebx image by default please see the [documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/customizing_the_image.html#_adding_a_new_jdbc_driver).



