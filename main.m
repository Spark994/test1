function test

	plib = para_lib();

	para = [];

	para = plib.para_add( 0, 'coeff_1', 'coefficente 1', 'double', para);

	c1 = plib.para_val( para, 'coeff_1' );
	fprintf('valore %f \n', c1 );	

return
