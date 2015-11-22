<?php
unset($_Session['status']);
session_start();
session_destroy();
?>