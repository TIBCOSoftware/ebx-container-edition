# Databases connectivity 

This table display all the ebx compatible database types. (L'image contient)

| Compatible database | Driver include  | Chart value type          |
|:--------------------|-----------------|---------------------------|
| PostgreSQL          | yes             | postgresql                |  
| SQL Server          | yes             | sqlserver                 |  
| H2                  | yes             | h2.standalone / h2.server |  Si référencé mettre sur des lignes différrentes
| Oracle              | no              | oracle                    |
| Azure SQL           | no              | azure.sql                 |
| Hana                | no              | hana                      |


TODO : mettre seulement ce qu'on supporte + reporter Chert value type dans les Readmes

Check this [Documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/customizing_the_image.html#_adding_a_new_jdbc_driver) for adding drivers that are not include in the ebx base image.


Colonne 1 (chart value type)
Colonne 2 (compatible databases)
Colonne 3 (Driver included by default) + liens vers bas de page 

### Database JDBC Drivers include in the image  

To install another driver please see the doc...



 