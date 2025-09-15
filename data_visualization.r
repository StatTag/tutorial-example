# This script creates a data visualization using R's ggplot2 library.
# It reads the cleaned data, prepares it for plotting, and generates a bar chart.

# Load necessary library
library(ggplot2)

# Define file paths
cleaned_data_path <- "cleaned_enrollment_data.csv"
output_plot_path <- "age_distribution_plot.png"

# Read the cleaned data from the CSV file
enrollment_data <- read.csv(cleaned_data_path)

# Prepare data for visualization
# Filter out rows where 'Treatment' is -1 (missing data handled in Python)
enrollment_data_filtered <- enrollment_data[enrollment_data$Treatment %in% c(0, 1), ]

# Create a factor for the treatment group labels for better plotting
enrollment_data_filtered$Treatment_Label <- factor(enrollment_data_filtered$Treatment,
                                                 levels = c(0, 1),
                                                 labels = c("Control", "Treatment"))

# Create a bar chart showing the age distribution by treatment group
age_distribution_plot <- ggplot(enrollment_data_filtered, aes(x = Age, fill = Treatment_Label)) +
  geom_histogram(binwidth = 5, position = "dodge", color = "black") +
  labs(
    title = "Age Distribution by Treatment Group",
    x = "Age",
    y = "Count",
    fill = "Group"
  ) +
  scale_fill_manual(values = c("Control" = "lightblue", "Treatment" = "salmon")) +
  theme_minimal()

# Save the plot to a PNG file
ggsave(output_plot_path, age_distribution_plot, width = 8, height = 6, dpi = 300)

cat("Age distribution plot saved to", output_plot_path, "\n")