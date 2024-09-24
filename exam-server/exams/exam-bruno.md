# Examen de Bruno
---

1. Cuales de las siguientes afirmaciones sobre IAM son correctas?
    - A. Los Permisos tienen Roles
    - B. Los Roles tienen Permisos
    - C. Los Grupos tienen Usuarios
    - D. Los Grupos tienen Permisos

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: BCD


    </details>

2. Cual de estos servicios de AWS es un servicio de base de datos NoSQL administrado?
    - A. Aurora
    - B. DynamoDB
    - C. IAM
    - D. RDS

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: B

    </details>

3. Para que sirve el user-data en una instancia EC2?
    - A. Para almacenar datos del usuario
    - B. Para ejecutar comandos al iniciar la instancia
    - C. Para almacenar datos de la instancia
    - D. Para almacenar datos de la región

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: B

    </details>

4. Cual de los siguientes servicios de AWS se utiliza para almacenar ficheros como objetos?
    - A. S3
    - B. RDS 
    - C. EC2
    - D. DynamoDB

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>

5. Para que me sirve saber que una aplicación es stateless?
    - A. Para saber que tiene un disco rígido
    - B. Para saber que potencialmente puede ser escalada horizontalmente
    - C. Para saber que usa una base de datos relacional
    - D. Para saber que puedo usar una cache

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: B

    Explanation: <https://aws.amazon.com/getting-started/tutorials/deploy-docker-containers/>

    </details>

6. Cual es la ventaja de usar un Network Load Balancer? (Selecciona dos)
    - A. Puede manejar millones de peticiones por segundo
    - B. Puede manejar peticiones de HTTP y HTTPS
    - C. Puede manejar peticiones de TCP y UDP
    - D. Puede usarse para correr aplicaciones en contenedores

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: AC

    </details>

7. Cuales de las siguientes afirmaciones sobre IAM son buenos practicas? (Selecciona dos)
    - A. Utilizar el usuario root para acceder a los servicios
    - B. Compartir credenciales de seguridad entre usuarios
    - C. Usar Roles de IAM para delegar permisos a los servicios
    - D. Rotar las claves de acceso regularmente
    - E. Usar claves de acceso en el código

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: CD

    Explanation: <https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html>

    </details>

8. Cual de los siguientes servicios utilizo para ver los logs de una Lambda?
    - A. AWS Config
    - B. AWS CloudWatch
    - C. AWS Trusted Advisor
    - D. AWS CloudTrail

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: B


    </details>

9. Cual de estas afirmaciones sobre bases de datos relacionales RDS es correcta? (Selecciona dos)
    - A. RDS es un servicio de base de datos NoSQL
    - B. RDS es un servicio de base de datos relacional
    - C. RDS es facilmente escalable horizontalmente
    - D. RDS es un servicio de base de datos administrado

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: BD

    </details>

10. Cuaales de las siguientes afirmaciones sobre Lambda son correctas? (Selecciona dos)
    - A. Lambda es un servicio de base de datos
    - B. Lambda es un servicio de computo sin servidor (serverless)
    - C. No debo asignar roles de IAM a una Lambda para que pueda acceder a otros servicios
    - D. Lambda es un servicio de almacenamiento de objetos
    - E. Idealmente, una Lambda debería ser stateless

    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: BE

    </details>
11. ¿Cuál de los siguientes servicios de AWS se utiliza para gestionar las credenciales de acceso a los recursos?

    - A. AWS IAM
    - B. AWS S3
    - C. AWS CloudFormation
    - D. AWS Route 53
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: A

    </details>
12. ¿Qué significa el término "autoescalado" en el contexto de AWS?

    - A. Crear instancias automáticamente en múltiples regiones.
    - B. Ajustar automáticamente el número de instancias EC2 según la demanda.
    - C. Escalar la base de datos RDS automáticamente.
    - D. Migrar datos entre instancias automáticamente.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>
13. ¿Cuál de los siguientes es un servicio de mensajería gestionado en AWS?

    - A. SNS
    - B. EC2
    - C. DynamoDB
    - D. Elastic Beanstalk
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: A

    </details>

14. ¿Qué característica define a una instancia "spot" en EC2?

    - A. Precio fijo y capacidad reservada.
    - B. Precio variable y la posibilidad de ser interrumpida por AWS.
    - C. Almacenamiento persistente en discos locales.
    - D. Uso garantizado durante todo el año.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>

15. ¿Para qué se utiliza el servicio AWS CloudTrail?

    - A. Para monitorear logs de red.
    - B. Para auditar y rastrear acciones realizadas en la cuenta de AWS.
    - C. Para generar alertas en tiempo real.
    - D. Para hacer copias de seguridad automáticas.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>
16. ¿Cuál de las siguientes afirmaciones sobre Elastic Load Balancer (ELB) es correcta?

    - A. Distribuye tráfico entre varias instancias en diferentes regiones.
    - B. Distribuye tráfico entre instancias en una única zona de disponibilidad.
    - C. Se utiliza para distribuir tráfico entre instancias EC2 y bases de datos.
    - D. Distribuye tráfico entre varias instancias en una o más zonas de disponibilidad.
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: D

    </details>
17. ¿Cuál es la principal función del servicio AWS CloudFormation?

    - A. Gestionar redes en la nube.
    - B. Proporcionar infraestructura como código para automatizar la creación de recursos.
    - C. Hacer copias de seguridad de datos en la nube.
    - D. Auditar y rastrear cambios en los recursos.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>

18. ¿Qué función cumple AWS VPC?

    - A. Proporciona una base de datos escalable.
    - B. Crea una red privada en la nube para aislar recursos.
    - C. Almacena objetos en la nube.
    - D. Gestiona usuarios y permisos.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>

19. ¿Cuál de las siguientes opciones describe una ventaja de AWS Lambda?

    - A. Necesita ser configurada con instancias EC2.
    - B. Permite ejecutar código sin aprovisionar ni administrar servidores.
    - C. Requiere el uso de contenedores Docker.
    - D. Funciona solo con bases de datos NoSQL.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>

20. ¿Qué tipo de servicio es Amazon RDS?

    - A. Almacenamiento de objetos.
    - B. Servicio de bases de datos relacionales administradas.
    - C. Servicio de mensajería en la nube.
    - D. Servicio de monitoreo de aplicaciones.
    
    <details markdown=1><summary markdown="span">Answer</summary>
    
    Correct Answer: B

    </details>
21. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
22. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
23. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
24. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
25. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
26. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
27. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
28. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
29. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
30. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
31. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
32. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
33. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
34. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
35. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
36. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
37. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
38. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
39. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
40. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
41. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
42. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
43. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
44. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
45. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
46. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
47. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
48. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
49. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>
50. N/A
    - A. N/A
    <details markdown=1><summary markdown="span">Answer</summary>

    Correct Answer: A

    </details>