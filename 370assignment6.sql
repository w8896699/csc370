CREATE TABLE Parts(
 pid int not null,
 pname char(40),
 color char(20)
);

insert into Parts values(123,'abc','red');
insert into Parts values(456,'abd','yellow');
insert into Parts values(457,'add','blue');
insert into Parts values(892,'adq','orange');
insert into Parts values(882,'aseq','pink');
insert into Parts values(782,'aeq','black');
insert into Parts values(563,'aeqt','white');
   Table "public.parts"
   
 Column |     Type      | Modifiers
--------+---------------+-----------
 pid    | integer       | not null
 pname  | character(40) |
 color  | character(20) |
 
 
CREATE TABLE partshistory(
 pid int not null,
 pname char(40),
 color char(20),
 operation char,
 opwhen TIMESTAMP,
 opuser char(20)
);
  Table "public.partshistory"
  Column   |            Type             | Modifiers
-----------+-----------------------------+-----------
 pid       | integer                     | not null
 pname     | character(40)               |
 color     | character(20)               |
 operation | character(1)                |
 opwhen    | timestamp without time zone |
 opuser    | character(20)               |
Triggers:
    pattsss AFTER INSERT OR DELETE OR UPDATE ON partshistory FOR EACH ROW EXECUTE PROCEDURE operations()
	
	


CREATE OR REPLACE FUNCTION operations() RETURNS TRIGGER AS $pattsss$
    BEGIN
       IF (TG_OP = 'DELETE') THEN
            INSERT INTO partshistory (pid, pname,color,operation,opwhen,opuser) values(OLD.pid,OLD.pname,OLD.color,'D',CURRENT_TIMESTAMP,'w8896699');
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO partshistory (pid, pname,color,operation,opwhen,opuser) values(OLD.pid,OLD.pname,OLD.color,'U',CURRENT_TIMESTAMP,'w8896699');
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO partshistory (pid, pname,color,operation,opwhen,opuser) values(OLD.pid,OLD.pname,OLD.color,'I',CURRENT_TIMESTAMP,'w8896699');
            RETURN NEW;
        END IF;

    END;
$pattsss$ LANGUAGE plpgsql;

CREATE TRIGGER pattsss
AFTER INSERT OR UPDATE OR DELETE ON Partshistory
 FOR EACH ROW 
 EXECUTE PROCEDURE operations();
 
 insert into Parts values(5263,'aeeqt','grey');
