RDY=$(findstring luleshomp,$(HPCTOOLKIT_EXAMPLE))

all: 
	@echo 
	@echo Specify one of the possible targets: 
	@echo "	build: build lulesh2.0"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"
	@echo

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LULESH_OMP_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh


run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LULESH_OMP_RUN)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun.sh

run-pc:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LULESH_OMP_RUN_PC)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-lulesh2.0-omp" \
	      	sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-lulesh2.0-omp-pc" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit*
	/bin/rm -rf log* .build*

distclean veryclean: clean
	/bin/rm -rf LULESH tarfile 
