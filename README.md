##  Classification and analysis of signals
This repository contains the implementation of three distinct signal processing tasks, each focusing on a different aspect of real-world signal analysis. These tasks involve feature extraction, classification, and segmentation, making use of various signal processing techniques and methodologies.


### 1. Bird Recognition
Bird species can be identified based on their unique audio signatures. This task involves analyzing bird call recordings and extracting distinguishing features to classify different bird species.
- **Objective**: Analyze the time and frequency characteristics of bird sounds to recognize species.
- **Input Data**: Audio files categorized into a reference dataset and a test dataset.
- **Approach**: Feature extraction and classification based on learned signal processing techniques.
- **Output**: Classification labels for each test audio file.

### 2. Heart Rate Estimation
Electrocardiogram (ECG) signals contain crucial information about heart activity. This task focuses on computing the heart rate from ECG signals while handling noise corruption.
- **Objective**: Compute heart rate from clean and noisy ECG signals.
- **Input Data**: ECG signals with a sampling rate of 128 samples per second.
- **Approach**: Noise removal using signal filtering techniques followed by peak detection for heart rate calculation.
- **Output**: Heart rate plotted as a function of time.

### 3. Loudness Segmentation
Speech conveys meaning through variations in loudness. This task involves segmenting speech based on loudness variations to identify emphasized words.
- **Objective**: Identify louder words in speech recordings with and without prior timing information.
- **Input Data**: Speech samples along with metadata indicating word timestamps and loudness annotations.
- **Approach**: Signal segmentation using amplitude analysis and dynamic thresholding.
- **Output**: Identified timestamps of louder words.

