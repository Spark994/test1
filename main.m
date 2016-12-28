function test

	plib = para_lib();

	plib.para_add( 0, 'coeff_1', 'coefficente 1', 'double');

	c1 = plib.para_val( 'coeff_1' );
	fprintf('valore %f \n', c1 );	

return
