# GetFluxtowerDataSet.R
#
# Reads a fluxnet variable from netcdf file
# Gab Abramowitz UNSW 2016 (palshelp at gmail dot com)
#
# Reads a variable from an internally converted netcdf
# file of a flux tower site's observed data.
GetFluxnetVariable = function(variable,name,filepath,flagonly=FALSE){
	library(ncdf4) # load netcdf library	
	exists_var = FALSE
	exists_qc = FALSE
	qc=NA # initialise
	errtext='ok'
	# Return if file does not exist:
	if(!file.exists(filepath)){
		errtext = paste('DS4: Data set file',name,
			'at',filepath,'does not exist.')
		obs=list(errtext=errtext,err=TRUE,exists=FALSE,qcexists=FALSE)
		return(obs)
	}
	# Open observed data file:
	fid=nc_open(filepath,write=FALSE,readunlim=FALSE)
	# Check required variable exists:
	vexists = NcvarExists(fid,variable)
	# If not, return with error:
	if(! vexists$var){
		dsetname = ncatt_get(fid,varid=0,attname='PALS_dataset_name')
		if(dsetname$hasatt){
			errtext = paste('DS2: Variable ',variable,
				' does not exist in data set ',name,sep='')
			obs=list(errtext=errtext,exists=FALSE,qcexists=FALSE,err=TRUE)
			fid = nc_close(fid)
			return(obs)
		}else{
			errtest = paste('DS2: Variable ',variable,
				'does not exist in data set',name,sep='')
			obs=list(errtext=errtext,exists=FALSE,err=TRUE,qcexists=FALSE)
			fid = nc_close(fid)
			return(obs)
		}
	}
	# Read QC data if it exists:
	if(vexists$qc){
		qc=ncvar_get(fid,paste(variable,'_qc',sep=''))
	}
	if(! flagonly){ # if this function call is actually about fetching data:
		timing = GetTimingNcfile(fid)
		data=ncvar_get(fid,variable)   # read observed variable data
		grid = GetGrid(fid)
		obs=list(data=data,timing=timing,qc=qc,qcexists=vexists$qc,name=name,
			grid=grid,err=FALSE,errtext=errtext)
	}else{
		obs=list(qcexists=vexists$qc,qc=qc,name=name,
			err=FALSE,errtext=errtext)
	}
	nc_close(fid) # close netcdf file	
	return(obs)
}
