# R_Anime_Shiny_App


### Introduction
I have created an interactive shiny application for a dataset on anime information. The dataset
includes columns for names, genres, ratings, type, id, number of members in the fanbase, and
number of episodes.
### Data Preparation:
I decided to mutate the dataset by removing missing values, changing the number of episodes
to numeric type, and altering the Genre column so that each anime is classified under only one
Genre. I did this to narrow down the number of genres from a few hundred to around forty. This
solved my issue with rendering the plots, because the plots considered each combination of
genres for each anime as a separate value, making it difficult to render.
### Interactive App Explanation:
My app consists of a dropdown where the user can select multiple genres to be plotted across
three different graphs and a table, as well as a radio button that selects for type of media for the
scatterplot.
● A stacked bar graph that plots Genres vs Average Number of Episodes, colored by type
of Medium;
● A box plot that plots ratings across different genres
● A scatter plot that plots the number of members per fanbase against the number of
episodes, colored by genre
○ There is also a radio button option for type of media for the scatter plot
● A table of the selected data
### Reactive Graph Structure:
#### 1. User Input:
As mentioned above, the user can select from a drop down of genres and the
type for the scatterplot specifically using the radio buttons.
#### 2. Reactive Components:
● My app includes a reactiveVal for selected and selected_genre, anime_df_subset
for the filtered data based on selected_genre, and scatterplot_data for filtered
data based on the selected type of media
#### 3. Output:
● As mentioned before, the output is three generated plots and a table.
![image](https://github.com/SaiVarad1/R_Anime_Shiny_App/assets/90008133/00687976-4267-41d7-a413-d2809071ed97)




### Interesting/Unexpected Findings:
Something interesting and unexpected was the presence of clear horizontal clusters on the
scatterplot that are stacked vertically on top of each other, as shown in the picture. The green
genres like Comedy seem to be consistently to the left, while the orange genres like Action are
consistently in the right half. This means that even though the fanbase of comedy anime seems
to be significantly smaller than that of action anime, the production studios that produce the
anime still are putting out a comparable number of episodes
