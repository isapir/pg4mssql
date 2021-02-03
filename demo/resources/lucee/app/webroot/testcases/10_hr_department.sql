/** 
    Ensure same columns and rows in HumanResources.Department 
*/

SELECT 	*
FROM 	HumanResources.Department D
WHERE 	D.GroupName = 'Research and Development';

---

SELECT 	*
FROM 	hr.department D
WHERE 	D.group_name = 'Research and Development';
