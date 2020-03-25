<?php

class DataBase
{
    private static $instance = null;
    private $pdo, $query, $error = false, $results, $count;
    
    private function __construct($pdo)
    {
        try
        {
            $this->pdo = $pdo;
        }
        catch(PDOException $exception)
        {
            die($exception->getMessage());
        }
    }
    
    private function __clone(){} // Чтобы не клонировали объект особо одаренные товарищи :)

    public static function getInstance() // PDO $pdo
    {
        if(!isset(self::$instance))
        {
            self::$instance = new self( new PDO("mysql:host=" . Config::get('mysql.host') . "; dbname=" . Config::get('mysql.database'), Config::get('mysql.username'), Config::get('mysql.password')) );
        }
        return self::$instance;
    }
    public function getAll($table)
    {
        $sql = "SELECT * FROM $table";
        if(!$this->query($sql)->error())
            return $this;

        return false;
        //$statement = $this->pdo->prepare($sql);
        //$statement->execute();
        //return $statement->fetchAll(PDO::FETCH_ASSOC);
    }

    /*
    
    
    public function getOne($table, $id)
    {
        $sql = "SELECT * FROM $table WHERE id = :id";
        $statement = $this->pdo->prepare($sql);
        $statement->bindValue(":id", $id);
        $statement->execute();
        return $statement->fetch(PDO::FETCH_ASSOC);
    }

    
    public function insert($table, $data)
    {
        $keys = array_keys($data);
        $sql = "INSERT INTO $table (" . implode(',',$keys) . ") VALUES (:" . implode(',:',$keys) . ")";
        $statement = $this->pdo->prepare($sql);
        $statement->execute($data);
    }

    public function update($table, $data, $id)
    {
        $sql = "UPDATE $table SET";
        $toggle = true;

        foreach($data as $key => $value)
        {
            if($toggle)
            {
                $sql .= " $key=:$key";
                $toggle = false;
            }
            else
                $sql .= ",$key=:$key";
        }

        $sql .= " WHERE id = :id";
        $data["id"] = $id;
        $statement = $this->pdo->prepare($sql);
        $statement->execute($data);
    }

    public function delete($table, $id)
    {
        $sql = "DELETE FROM $table WHERE id = :id";
        $statement = $this->pdo->prepare($sql);
        $statement->bindValue(':id', $id);
        $statement->execute();
    }
    */

    public function query($sql, $params = [])
    {
        $this->error = false;
        $this->query = $this->pdo->prepare($sql);

        if( count($params) )
        {
            $i = 1;
            foreach ($params as $param)
            {
                $this->query->bindValue($i, $param);
                $i++;
            }
        }

        if(!$this->query->execute())
        {
            $this->error = true;
        }
        else
        {
            $this->results = $this->query->fetchAll(PDO::FETCH_OBJ);
            $this->count = $this->query->rowCount();
        }

        return $this;
    }

    public function error()
    {
        return $this->error;
    }

    public function results()
    {
        return $this->results;
    }

    public function first()
    {
        return $this->results()[0];
    }

    public function count()
    {
        return $this->count;
    }

    public function get($table, $where = [])
    {
        return $this->action("SELECT *", $table, $where);
    }

    public function delete($table, $where = [])
    {
        return $this->action("DELETE", $table, $where);
    }

    public function action($action, $table, $where = [])
    {
        if( count($where) === 3 )
        {
            $operators = ['=', '>', '<', '>=', '<='];

            $field = $where[0];
            $operator = $where[1];
            $value = $where[2];

            if( in_array($operator, $operators) )
            {
                $sql = "$action FROM $table WHERE $field $operator ?";

                if( !$this->query($sql, [$value])->error() )
                {
                    return $this;
                }
            }
        }

        return false;

    }

    public function insert($table, $fields = [])
    {
        $values = '';
        foreach ($fields as $field) {
             $values .= '?,';
        }
        $values = rtrim($values, ',');

        $sql = "INSERT INTO $table (" . implode(',', array_keys($fields)) . ") VALUES (" . $values . ")";

        if( !$this->query($sql, $fields)->error() )
        {
            return true;
        }

        return false;
    }

    public function update($table, $id, $fields = [])
    {
        $set = '';
        foreach ($fields as $key => $field) {
             $set .= "$key = ?,";
        }

        $set = rtrim($set, ',');

        $sql = "UPDATE $table SET $set WHERE id = $id";

        //echo $sql; die;

        if( !$this->query($sql, $fields)->error() )
        {
            return true;
        }

        return false;
    }
}