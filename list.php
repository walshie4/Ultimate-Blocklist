<?php

/**
 * Blocklist supplying over the Internet
 * Just fetch using http://mydomain.com/list.php
 *
 * This will provide the list
 * @author  Alexandre Vallières-Lagacé <alexandre@vallier.es>
 * @version 1.0
 */

	// We'll be outputting a PDF
	header('Content-type: text/plain');

	// It will be called downloaded.pdf
	header('Content-Disposition: attachment; filename="list.txt"');

	// The PDF source is in original.pdf
	readfile('list.txt');

?>