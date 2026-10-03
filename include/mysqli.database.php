<?php

require_once __DIR__ . DIRECTORY_SEPARATOR . "database.interface.php";

/**
 * MySQLi Implementation of the Database Abstraction Layer
 */
class MysqliDatabase implements DatabaseInterface {
    private $link;

    public function connect($server, $username, $password, $new_link = false, $client_flags = 0) {
        // PHP 8.1+ throws mysqli_sql_exception by default. The application
        // checks return values and errno() instead, so keep the legacy mode.
        mysqli_report(MYSQLI_REPORT_OFF);

        // Legacy "host:port" / "host:/path/to/socket" notation of ext/mysql
        $host   = $server;
        $port   = null;
        $socket = null;
        if (is_string($server) && preg_match('/^([^:]*):(.+)$/', $server, $parts)) {
            $host = $parts[1];
            if (ctype_digit($parts[2])) {
                $port = (int) $parts[2];
            } else {
                $socket = $parts[2];
            }
        }

        try {
            $this->link = @mysqli_connect($host, $username, $password, null, $port, $socket);
        } catch (Exception $e) {
            $this->link = false;
        }
        return $this->link;
    }

    public function setCharset($charset) {
        if (!($this->link instanceof mysqli)) return false;
        return mysqli_set_charset($this->link, $charset);
    }

    public function selectDb($database_name) {
        if (!($this->link instanceof mysqli)) return false;
        return mysqli_select_db($this->link, $database_name);
    }

    public function query($query) {
        if (!($this->link instanceof mysqli)) return false;
        return mysqli_query($this->link, $query);
    }

    public function fetchArray($result, $result_type = MYSQLI_BOTH) {
        if (!($result instanceof mysqli_result)) return false;
        return mysqli_fetch_array($result, $result_type);
    }

    public function fetchAssoc($result) {
        if (!($result instanceof mysqli_result)) return false;
        return mysqli_fetch_assoc($result);
    }

    public function fetchRow($result) {
        if (!($result instanceof mysqli_result)) return false;
        return mysqli_fetch_row($result);
    }

    public function numRows($result) {
        if (!($result instanceof mysqli_result)) return 0;
        return mysqli_num_rows($result);
    }

    public function error() {
        if (!($this->link instanceof mysqli)) return (string) mysqli_connect_error();
        return mysqli_error($this->link);
    }

    public function errno() {
        if (!($this->link instanceof mysqli)) return mysqli_connect_errno();
        return mysqli_errno($this->link);
    }

    public function realEscapeString($unescaped_string) {
        if (!($this->link instanceof mysqli)) return addslashes($unescaped_string);
        return mysqli_real_escape_string($this->link, $unescaped_string);
    }

    public function close() {
        if (!($this->link instanceof mysqli)) return true;
        return mysqli_close($this->link);
    }

    public function dataSeek($result, $row_number) {
        if (!($result instanceof mysqli_result)) return false;
        return mysqli_data_seek($result, $row_number);
    }

    public function insertId() {
        if (!($this->link instanceof mysqli)) return 0;
        return mysqli_insert_id($this->link);
    }

    public function execute($query, array $params = []) {
        if (!($this->link instanceof mysqli)) return false;

        // mysqli_execute_query is PHP 8.2+
        if (version_compare(PHP_VERSION, '8.2.0', '>=') && function_exists('mysqli_execute_query')) {
            return mysqli_execute_query($this->link, $query, $params);
        }

        // Fallback for PHP < 8.2
        $stmt = mysqli_prepare($this->link, $query);
        if (!$stmt) return false;

        if (!empty($params)) {
            $types = "";
            foreach ($params as $param) {
                if (is_int($param)) $types .= "i";
                elseif (is_double($param)) $types .= "d";
                elseif (is_string($param)) $types .= "s";
                else $types .= "b";
            }
            $bind_names = array($stmt, $types);
            foreach ($params as $key => $value) {
                $bind_names[] = &$params[$key];
            }
            call_user_func_array('mysqli_stmt_bind_param', $bind_names);
        }

        if (!mysqli_stmt_execute($stmt)) {
            mysqli_stmt_close($stmt);
            return false;
        }

        $result = mysqli_stmt_get_result($stmt);
        if ($result === false && mysqli_stmt_errno($stmt) === 0) {
            // For non-SELECT queries that succeeded
            $result = true;
        }

        mysqli_stmt_close($stmt);
        return $result;
    }
}
