# HMO-Healthcare-Cost-Prediction
## Introduction
The primary goal of this project is to provide actionable insights and accurate predictions on which individuals are likely to incur higher healthcare costs. The dataset includes healthcare cost information from an HMO (Health Management Organization), with each row representing an individual. We operate as a consultancy firm for HMOs, aiming to reduce overall healthcare costs by advising on cost-cutting strategies or revenue-enhancing plans.

## Business Questions
After analyzing the problem statement, we've identified key business questions:

1. Does smoking impact healthcare costs?
2. Is there a correlation between exercise and higher healthcare expenses?
3. Which demographic segment incurs the highest healthcare expenses?
4. How does the number of children contribute to healthcare costs?
5. What strategies could be implemented to reduce healthcare expenses?

## Dataset Characteristics
Dataset Link: <a href = "https://intro-datascience.s3.us-east-2.amazonaws.com/HMO_data.csv"> HMO-Healthcare-Cost-Prediction </a> (filename: HMO_data.csv) <br>
The dataset comprises 7582 observations and 14 attributes.

## Data Preparation and Cleaning
### 1. Handling Missing Values
- Identified 78 missing values for BMI and 80 for hypertension.
- Employed 'na_interpolation' with the linear option to fill BMI gaps.
- Used a random number generator to address missing values in the hypertension column due to its binary nature.

### 2. Standardizing Text to Lower Case
- Ensured uniformity by converting all textual data to lowercase throughout the dataset.

### 3. Factorizing Data
- Converted specific columns (smoker, location_type, education_level, yearly_physical, exercise, married, gender) into factors for modeling purposes.

### 4. Point System for Healthcare Cost Estimation
- To assess individual healthcare cost implications, we've implemented a scoring system that considers various factors:
    1. Cost greater than 5000: Subtract 5 points
    2. Smoker: Subtract 4 points
    3. BMI within the healthy range (18.5 to 24.9): Add 3 points
    4. Age less than or equal to 40: Add 2 points
    5. Active in exercise: Add 1 point
       
- How it works:
  - Initialize a 'score' column with a value of 0 for each individual.
  - Adjust scores based on the above conditions.
- Interpret the scores:
  -  Positive scores: Indicate lower expected healthcare costs
  - Negative scores: Indicate higher expected healthcare costs

## Exploratory Data Analysis
### 1. Individual Attribute Distribution
1. **Age**: The distribution of ages follows a binomial pattern, with higher concentrations of individuals below the age of 20, suggesting a significant portion of younger people within the dataset.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/47636950-f18e-4f78-a24d-3290ce739f34)


2. **BMI (Body Mass Index)**: BMI values showcase a normal distribution, with an average of 30.79. This points to a prevalent occurrence of obesity within the observed population.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/8846d112-25c0-4e24-83dd-ad73c8e4f022)

3. **Children**: The 'Children' column ranges from 0 to 5, and on average, individuals in the dataset have approximately 1.1 children, indicating a lower average number of children among the observed individuals.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/4f030fc3-9f14-4b11-aee2-7764e5f371d5)

4. **Smoker**: There are 5975 non-smokers and 1449 smokers within the dataset, demonstrating a higher representation of non-smokers than smokers.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/f1b47790-1109-43d9-bcbf-8755b98f83b1)

5. **Location**: Individuals are distributed across specific states, including Connecticut, Maryland, Massachusetts, New Jersey, New York, Pennsylvania, and Rhode Island, denoting a geographical diversity within the dataset.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/94929cd0-eb3c-4841-9672-c334da5cf3df)

6. **Location Type**: Observations consist of rural (1854) and urban (5570) settings, showing a higher representation of urban observations.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/8cd65062-0694-4b3e-af40-d90e0a2e438e)

7. **Education Level**: Categories encompass individuals with varying education levels, including those without a college degree, bachelor's degree holders, master's degree holders, and individuals with a PhD, indicating a diverse educational background within the dataset.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/48da3b1a-0228-457d-bde7-c1b79422e3db)

8. **Yearly Physical**: Among the observations, 5585 individuals did not have a yearly physical checkup, while 1839 individuals reported having visited a doctor annually, pointing to a smaller proportion of individuals engaging in regular checkups.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/017fc709-9069-4b7c-846e-db2efe8e254b)

9. **Exercise**: Of the observed individuals, 1850 are classified as active in exercise, while 5574 individuals are not actively engaged in exercise, indicating a larger segment of the population that does not engage in regular physical activity.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/f4b4c80b-36c9-42e8-814a-c1e862dd55dc)

10. **Married**: The dataset includes 4951 married individuals and 2473 individuals who are not married, portraying a varied marital status among the observed population.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/469b2d51-8e7e-4d6f-acf3-687fc23401f8)

11. **Hypertension**: 5934 individuals do not exhibit hypertension, while 1490 individuals are identified with hypertension, indicating a smaller proportion of individuals with high blood pressure within the dataset.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/70f2c16c-121e-44f6-9ab8-c264e6fb1853)

12. **Gender**: Observations include 3587 females and 3837 males, showcasing a balanced gender representation within the dataset.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/54dc98ff-9522-4a45-a067-b9e49649dc64)

### 2. Relationship with Cost
Analyzed correlations between attributes and healthcare costs.

1. **Smoker's Impact: BMI vs. Healthcare Cost**: In this scatter plot analysis, a distinct pattern emerges showcasing the relationship between BMI, healthcare costs, and smoking status. Non-smokers generally exhibit lower healthcare costs compared to smokers. Interestingly, a noticeable cluster with a BMI above 30 (indicating obesity) stands out, indicating higher costs among smokers.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/654d8597-9bd5-4f0a-89e8-d0e2e95131e7)

2. **Exercise Influence: BMI vs. Healthcare Cost**: This scatter plot reveals a clear correlation between non-exercisers, higher BMI values, and increased healthcare costs. Individuals classified as non-active, especially those with elevated BMI values, tend to have higher healthcare expenses, highlighting a relationship between exercise patterns and healthcare costs.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/30f98ab8-50be-42d6-af48-3ff813634d17)

3. **Exercise Influence: Age vs. Healthcare Cost**: The graph illustrates a relationship between age, exercise habits, and healthcare expenses. It vividly shows that as individuals age and engage less in exercise, their healthcare expenditures notably increase, showcasing the correlation between age, exercise routines, and healthcare costs.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/11bfd50f-773f-4996-b266-95438bc5c990)

4. **Age vs. Healthcare Cost for Smokers**: As expected, this graph depicting age, smoker status, and healthcare costs supports the idea that smokers generally face higher expenses. Furthermore, the correlation between advancing age and increased healthcare costs is particularly accentuated among smokers, showcasing higher costs compared to non-smokers as age progresses.

![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/ee5d060d-5521-4068-841d-504f335b6032)

### 3. Average Cost by State (Map)
Visualized average costs across select states, particularly highlighting higher costs in New York.
![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/4fc54c94-a528-42ec-a7d1-8d69ca8b8c72)

## Splitting Data Set to Test-Train
- Created a train-test split (60-40%) for model training and validation.

## Training Models
We aim to predict whether an individual will incur high healthcare costs next year. We achieved this by building and evaluating several classification models using supervised learning. Each model outputs a categorical classification of "expensive" or "not expensive" based on the input data.

### 1. Linear Regression:
- Accurately identified 89.18% of cases.
- Strong ability to identify "not expensive" cases (Sensitivity: 96.28%).
- Moderate ability to identify "expensive" cases (Specificity: 68.52%).
- Coefficients reveal key factors influencing cost, such as age, BMI, smoking, and exercise.

### 2. Decision Tree:
- Best overall performance: Accuracy of 89.35% and Kappa coefficient of 0.6813.
- Exceptional sensitivity of 99.20%, accurately identifying true "not expensive" cases.
- Balanced accuracy of 79.92% across both categories.

### 3. Support Vector Machine (SVM):
- Reasonable accuracy of 87.53% and Kappa coefficient of 0.6417.
- High sensitivity of 96.10% for recognizing "not expensive" cases.
- Lower specificity of 62.58% for identifying "expensive" cases.

## Actionable Insights
- Smoking, lack of exercise, high BMI, and older age are associated with higher healthcare costs.
- The number of children does not significantly impact cost.
- Interventions targeting exercise, healthy diet, smoking cessation, and moderate alcohol consumption could reduce costs.
- Incentives might include discounted health packages, gym memberships, medical checkups, and dietitian consultations for high-risk individuals.

## Conclusion
The Decision Tree model provides the best balance of accuracy and sensitivity for predicting high healthcare costs. Our analysis also identifies key factors driving costs and suggests potential interventions to reduce them. This information can be valuable for healthcare providers and policymakers in managing and minimizing healthcare expenses.

## Shiny Application
To further explore and interact with the best model, we've developed a user-friendly Shiny application. This web app allows you to input individual characteristics (age, BMI, smoking status, etc.) and instantly see the predicted future healthcare cost category ("expensive" or "not expensive"). Access the Shiny app to test the model yourself and gain a deeper understanding of potential healthcare expenses!
***Shiny Application link*** : <a href = "https://doshiharmish.shinyapps.io/Project_Final_ShinyApp/"> HMO-Healthcare-Cost-Prediction </a>
<br>***Files to be used***:
<br>
1. treeModel.csv (Sample Input File)
2. HMO_TEST_data_sample_solution.csv <br>
![image](https://github.com/doshiharmish/HMO-Healthcare-Cost-Prediction/assets/16878994/d7a36831-839b-4117-b001-922ba74628b3)
