Heritage Marketplace AI - Where Every Purchase Preserves a Story

BigQuery AI system that connects customers seeking authentic cultural gifts with artisans whose heritage aligns with their values through intelligent pattern recognition.

Overview

Heritage Marketplace AI solves the problem of cultural marketplace search by moving beyond keyword matching to understand cultural context and meaning. The system matches customer cultural desires with artisan heritage stories, creating authentic connections that preserve traditions through commerce.

Problem Solved

Traditional marketplace search returns generic results when customers seek culturally meaningful items. A customer wanting "Persian poetry and calligraphy traditions" gets mass-produced items instead of finding the third-generation Persian calligrapher whose family preserves poetry through craft.

Technical Implementation

Platform: Google BigQuery
Approach: Cultural pattern recognition using CASE statements and REGEXP_CONTAINS
Matching Algorithm: Rule-based semantic understanding of cultural heritage connections
Scoring: Predetermined cultural alignment scores based on heritage patterns
How to Run

Prerequisites

Google Cloud Platform account
BigQuery access enabled
Project with billing enabled
Setup Instructions

Create BigQuery Dataset
sql

CREATE SCHEMA IF NOT EXISTS `your-project-id.marketplace_data`;

Run the Complete Implementation Execute the SQL code in heritage_marketplace_code.sql step by step:
Steps 1-2: Create and populate customer desires table
Steps 3-4: Create and populate artisan stories table
Step 5: Generate cultural matches with scoring algorithm
Step 6: Run demo query to see results
View Results
sql

SELECT * FROM `your-project-id.marketplace_data.cultural_matches`

ORDER BY customer_id, match_rank;

Expected Results

The system achieves:

0.95 similarity score for Persian heritage customer → Persian calligrapher match
0.90 score for Japanese customer → Japanese metalworker match
0.85 score for Italian customer → Italian glassmaker match
Cross-cultural matching for wedding couple seeking Japanese-Italian fusion
Cultural Matching Logic

The algorithm identifies cultural connections through:

Heritage pattern recognition (Persian/Iranian, Japanese, Italian)
Craft tradition alignment (calligraphy, metalwork, glassmaking)
Cultural philosophy matching (wabi-sabi, traditional techniques)
Contextual rule-based scoring
Business Impact

Increases authentic customer-artisan matching accuracy
Makes traditional techniques economically viable
Preserves cultural heritage through meaningful commerce connections
Scales to support any cultural marketplace prioritizing authentic heritage
Competition Entry

This project was created for the BigQuery AI Hackathon 2025, demonstrating semantic matching capabilities using BigQuery's pattern recognition functions to solve real-world cultural commerce challenges.

Contact

For questions about implementation or collaboration opportunities, connect via the project's Kaggle competition submission.

 
