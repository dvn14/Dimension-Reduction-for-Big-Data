# Dimension Reduction For Big Data

## Abstract 

Big Data is a field that has grown in popularity among many companies today. Expanding technological progress has caused data to grow in both size and complexity, which results in inherent statistical and computational difficulty for a standard machine. This project implements random projectors which embed high dimensional data onto a low dimensional subspace in the Euclidean space, that are called Fast Johnson-Lindenstrauss Transforms. It considers concepts of sparse matrices, error correcting codes, and BCH codes which are used to yield low dimensional structure given a small distortion. The critical features analysed are, the computation time and the probability of success for different embedded dimensions of each algorithm. K-Nearest Neighbours Search Algorithm, a machine learning technique, is used to analyse the performance and feasibility of the random projectors in practice. The primary focus of this project is to explore algorithms for dimension reduction and compare their performances and characteristics.

## Aims and Objectives

The main aim of this project is to address the computational and statistical difficulties that are caused by Big Data. This project discusses the prospect of embedding data in high-dimensional space to a low-dimensional subspace through random projections. The advantage of dimension reduction is that traditional data processing and learning algorithms can be applied to data without any of the drawbacks caused due to high dimensionality.

The project focuses is on developing random projection techniques for dimensional reduction and subsequently, tests, evaluates, and compares these methods with respect to computation time, reduced dimension, and the correctness. In this project, data was part of the Euclidean space where the projection was from a high-dimensional Euclidean space to a random low-dimensional Euclidean subspace. After preparing data in the reduced dimension, it was used in an instance-based learning algorithm which evaluated the projection technique's correctness.

Using the idea of dimension reduction, this project examined the lowest and highest reduced dimensions a method can achieve, the behaviour of probability error for reduced dimensions, and the performance between reduced dimensional data and high-dimensional data. The report initially discusses the technical background covering essential information required for the random projection techniques. Following this, the random projection techniques are introduced, and the architecture of each method is covered. Then, the implementation of the systems is explained, followed by the testing processes, covering all aspects in order to arrive at promising results. Finally the results obtained from the testing processes is covered, and based on the performance comparisons the methods were evaluated. Thus arriving at conclusions to provide results and supporting evidence to answer the questions:

1. What is a feasible architecture for a random projection technique?
2. Will the reduced dimensional data provide promising results on the learning algorithm in comparison to the high dimensional data?
3. If so, can reduced dimensional data be a substitute for any high dimensional data?
