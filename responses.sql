/* 1 */
select *
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
where chf.salario < emp.salario;

/* 2 */
select dep.nome,
    max(emp.salario)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome;

/* ---3--- */
select dep.nome, 
    emp.nome,
    max(emp.salario)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by emp.nome,
    dep.nome;
