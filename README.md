# Latent-Dirichlet-Allocation-LDA-(code in MATLAB) 
 * natural language processing algorithm 
 * a probabilistic generative model
 * for the classification of documents based on topic proportions and word proportions using Latent Dirichlet Allocation
 * the Bayesian Inference used Collapsed Gibbs sampling
 * faster convergence than a conventional Gibbs sampler and low error ratio
 * Reference : Thomas L. Griffiths and Mark Steyvers Finding Scientific Topics (2004)

**Here Vocabulary considered is of size 16 and is represented using a 4x4 image.**
**Each pixel in the image represents a word in the vocabulary. The Brighter the pixel, the higher is its frequency in the document/topic. Here 8 topics were assumed as the ground truth with the word distribution as shown in the image below. Now Using these topics 500 documents of length 100 were generated. Examples of documents generated are shown below in the image. Now LDA was ran(over 500 iterations) on these generated documents, and topics were discoverd. Topics discovered at initial iteration and final iteration are shown in the screenshots below**

**Theta Ground Truth values**
![image](https://cloud.githubusercontent.com/assets/15040734/21571298/e5e304c8-cef3-11e6-9b65-ef9a306e0249.png)

**Example Documents**

![image](https://cloud.githubusercontent.com/assets/15040734/21571315/1a4b993c-cef4-11e6-8520-32bcc04a055e.png)

**Initial Phi Iteration**

![image](https://cloud.githubusercontent.com/assets/15040734/21571339/4fb7e40e-cef4-11e6-887c-8495f8aef2c1.png)

**Final Phi Iteration**

![image](https://cloud.githubusercontent.com/assets/15040734/21571338/4cda5546-cef4-11e6-8bb5-11dfffd4a19c.png)

It contains the following functions:

1)code LDA Matlab.m implements the function to learn LDA parameters using Gibbs sampling
The equations of the conditional posterior is based on the technical note by Yi Wang,
"Gibbs Sampling and Latent Diriclet Allocation: The Gritty Details ", 
available from http://dbgroup.cs.tsinghua.edu.cn/wangyi/lda/index.html

2)gen_images.m contains the codes to generate the graphical example as in the paper
"Finding scientific topics" by T. L. Griffiths and M. Steyvers, 2004.

3)dirrnd.m implements the sampling from a Dirichlet distribution.

4)run_GibbsLDA.m is main code to call to run the demo.
