"""
Clean customer reviews data for e-commerce analytics project.
Removes nulls, duplicates, and embedded newlines.
"""

import pandas as pd

# Read the CSV file
df = pd.read_csv('olist_order_reviews_dataset.csv')

# Remove nulls and empty strings from review_id
df = df[df['review_id'].notna()]
df = df[df['review_id'].str.strip() != '']

# Remove duplicates based on review_id
df = df.drop_duplicates(subset=['review_id'], keep='first')

# Remove embedded newlines from ALL text columns
text_columns = ['review_id', 'order_id', 'review_comment_title', 'review_comment_message']

for col in text_columns:
    if col in df.columns:
        df[col] = df[col].str.replace('\n', ' ', regex=False)
        df[col] = df[col].str.replace('\r', ' ', regex=False)
        df[col] = df[col].str.replace('  +', ' ', regex=True)
        df[col] = df[col].str.strip()

# Save the cleaned file
df.to_csv('reviews_cleaned.csv', index=False)

print(f"Cleaned successfully! Total rows: {len(df)}")