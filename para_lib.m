%
%	Parameter I/O handling in matlab
%
function lib = para_lib();
	lib.para_add = @para_add;
	lib.para_val = @para_val;
	lib.load_pars = @load_pars;
	lib.save_pars = @save_pars;
	lib.print_pars = @print_pars;
return
%==============================================
function [ para, err ] = load_pars( para, fname )
    err = 0;
    update_file = fopen(fname , 'r');
    if update_file == -1;  	err = 1;   	return;    end;
    while ~feof(update_file)
        s = fgetl(update_file);  %get the line
        [str] = strread(s,'%s');
        if length( str ) > 0; name = char (str(1)); else ; name = ''; end;

        par_N = length(para);
        %checking the para structure
        for i = 1:par_N;
            if strcmp(name , para(i).name);
                clear value;
                 if strcmp('char' , para(i).type);
                        value = char (str(2));
                        para(i).val = value;
                 elseif strcmp('double' , para(i).type);
                        value = str2double(str(2));
                        para(i).val = value;  
                 elseif strcmp('int' , para(i).type);
                        value = str2double(str(2));
                        para(i).val = value;  
                 end
                 break;
            end
        end
    end
	fclose(update_file);
return
%==============================================
function print_pars( para )
	par_N = length(para);
	for i = 1:par_N
    	switch para(i).type
    	    case 'char'
    	        fprintf( '%15s \t %10s \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'double'
    	        fprintf( '%15s \t %10.2e \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'int'
    	        fprintf( '%15s \t %10d \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'comment'
    	        fprintf( '%s \n', para(i).comm );
    	    otherwise
    	        fprintf( 'bad error \n' );
    	end
	end
return
%==============================================
function save_pars( para, fname )
    fid = fopen( fname ,'w');
    par_N = length(para);
    for i = 1:par_N
        switch para(i).type
    	    case 'char'
    	        fprintf( fid, '%15s \t %10s \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'double'
    	        fprintf( fid, '%15s \t %10.2f \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'int'
    	        fprintf( fid, '%15s \t %10d \t %s \n', para(i).name, para(i).val, para(i).comm );
    	    case 'comment'
    	        fprintf( fid, '%s \n', para(i).comm );
    	    otherwise
    	        fprintf( fid, 'bad error \n' );
        end
    end
    fclose(fid);
return
%==============================================
function para = para_add( val, name, comment, type, para )
	par_N = length( para );
	N = par_N+1;
	para( N ).name = name;
	para( N ).val = val;
	para( N ).comm = comment;
	para( N ).type = type;
return
%==============================================
function val = para_val( para, name );
	val = NaN;
	par_N = length(para);
	for i = 1:par_N;
	    if strcmp(name , para(i).name);
			val = para(i).val;
	        break;
	    end
	    if i == par_N
	    	txt = sprintf('Parameter not found: %s', name);
	    	eerror(txt);
	    end
	end
return
%=====================================================================================================
function eerror(txt)
	fprintf('Unrecoverable error: %s \n', txt);
	fprintf('Program is stopping - Press any key \n');
	pause
	fprintf('bye \n');
	error('Program error','Program error');
return



