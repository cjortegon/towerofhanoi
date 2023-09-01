# Tower of Hanoi Demo

### Author

Camilo Ortegón

[www.camiloortegon.com](https://camiloortegon.com/)

### Licence

The ISC (Internet Systems Consortium) license is a permissive open-source software license that allows users to freely use, modify, distribute, and redistribute the software. It imposes minimal restrictions, requiring typically only the inclusion of the original copyright notice and license text when redistributing the software. ISC encourages collaboration and software development by providing developers with considerable freedom to utilize and share the code, similar in spirit to other permissive licenses like the MIT and BSD licenses.

## How to use

This repository contains both the Service developed in **NodeJS** to solve the Tower of Hanoi problem, and the App developed in **Flutter** that uses this service to show the solution to n number of disks (maximum 10).

Open the `/app` project in Android Studio.

The Hanoi problem service has been deployed in the following location:

>   
    [GET] https://gq3ykajn8g.execute-api.us-east-1.amazonaws.com/prod/client/incode/hanoi?disks=

    Headers:
    Authorization aaa
