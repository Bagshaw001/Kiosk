<?php
//database

//database credentials
require_once(__DIR__.'/env_manager.php');

/**
 *@author David Sampah
 *@version 1.1
 */
class db_connection
{
	//properties
	public $db = null;
	public $results = null;

	//connect
	/**
	*Database connection
	*@return bolean
	**/
	function db_connect(){

		//connection
		// $this->db = mysqli_connect(SERVER,USERNAME,PASSWD,DATABASE);
		$this->db = mysqli_connect(db_server(),db_username(),db_pass(),db_name());

		//test the connection
		if (mysqli_connect_errno()) {
			return false;
		}else{
			return true;
		}
	}

	//execute a query
	/**
	*Query the Database
	*@param takes a connection and sql query
	*@return a boolean[FALSE] if query failed; entry id if query was successful
	**/
	function db_query($sqlQuery){


		if (!$this->db_connect()) {
			return false;
		}
		elseif ($this->db==null) {
			return false;
		}

		//run query
		$this->results = mysqli_query($this->db,$sqlQuery);

		if ($this->results == false) {
			return false;
		}else{
			return true;
			return mysqli_insert_id($this->db);
		}
	}



	//fetch a data
	/**
	*get select data
	*@return a record
	**/
	function db_fetch_one($sql){

		// if executing query returns false
		if(!$this->db_query($sql)){
			return false;
		}
		//return a record
		return mysqli_fetch_assoc($this->results);
	}

	//fetch all data
	/**
	*get select data
	*@return all record
	**/
	function db_fetch_all($sql){

		// if executing query returns false
		if(!$this->db_query($sql)){
			return false;
		}
		//return all record
		return mysqli_fetch_all($this->results, MYSQLI_ASSOC);
	}


	//count data
	/**
	*get select data
	*@return a count
	**/
	function db_count(){

		//check if result was set
		if ($this->results == null) {
			return false;
		}
		elseif ($this->results == false) {
			return false;
		}

		//return a record
		return mysqli_num_rows($this->results);

	}
}
?>