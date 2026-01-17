Remove-Item "C:\xampp\tomcat\webapps\compagnie-aerienne" -Recurse -Force; 
Remove-Item "C:\xampp\tomcat\webapps\compagnie-aerienne.war" -Force; 
Copy-Item "D:\ITU\S5\Mme_Baovola\aero_2\CompagnieAerienne\target\compagnie-aerienne.war" -Destination "C:\xampp\tomcat\webapps\"