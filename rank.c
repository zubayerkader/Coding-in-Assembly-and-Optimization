void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
	//variables initialized to decrease memory access
	int i, j;
	*num_passed = 0;
	*avg = 0.0;
	*passing_avg = 0.0;
	float x;						
	float y;
	float z;
	float v;
	float w;

	//pointer variables initialized to decrease memory access
	int num_passedT = 0;			
	float avgT = 0.0;
	float passing_avgT = 0.0;

	// init ranks
	//unroll loop
	i=4;
	while (i<N){				
		R[i] = 1;
		R[i - 1] = 1;
		R[i - 2] = 1;
		R[i - 3] = 1;
		R[i - 4] = 1;
		
		//variables set to decrease memory access
		x = F[i];				
		y = F[i - 1];
		z = F[i - 2];
		v = F[i - 3];
		w = F[i - 4];

		avgT += x;
		avgT += y;
		avgT += z;
		avgT += v;
		avgT += w;

		//added average calculations to first loop to do both calculations at once
		if (x >= 50.0) {          
			passing_avgT += x;
			num_passedT += 1;
		}
		if (y >= 50.0) {
			passing_avgT += y;
			num_passedT += 1;
		}
		if (z >= 50.0) {
			passing_avgT += z;
			num_passedT += 1;
		}
		if (v >= 50.0) {
			passing_avgT += v;
			num_passedT += 1;
		}
		if (w >= 50.0) {
			passing_avgT += w;
			num_passedT += 1;
		}
		i = i + 5;

	}
	//if unrolled value is odd
	while (i<=N){					
		R[i - 1] = 1;

		avgT += F[i - 1];

		y = F[i - 1];

		if (y >= 50.0) {
			passing_avgT += y;
			num_passedT += 1;
		}
		i++;
	}


	// compute ranks
	//outer loop unrolled to decrease number of iterations  
	i=4;	
	while (i<N){					     
		j=0;
		while(j<N){		
			if (F[i] < F[j]) {
				R[i] += 1;
			}
			if (F[i - 1] < F[j]) {
				R[i - 1] += 1;
			}
			if (F[i - 2] < F[j]) {
				R[i - 2] += 1;
			}
			if (F[i - 3] < F[j]) {
				R[i - 3] += 1;
			}
			if (F[i - 4] < F[j]) {
				R[i - 4] += 1;
			}
			j++;
		}
		i = i + 5;
	}

	//if unrolled value is odd 
	while (i<=N){					           
		j=0;
		while (j<N){
			if (F[i - 1] < F[j]) {
				R[i - 1] += 1;
			}
			j++;
		}
		i++;
	}
	// compute averages

	// check for div by 0
	if (N > 0) 
		avgT /= N;
	if (num_passedT) 
		passing_avgT /= num_passedT;

	//set variable calculations back to their pointers
	*num_passed = num_passedT;                       
	*avg = avgT;
	*passing_avg = passing_avgT;

} // compute_ranks

