import pandas as pd
import numpy as np
class GNB(object):

	def __init__(self):
		self.possible_labels = ['left', 'keep', 'right']
		self.data_means = ''
		self.data_variance = ''
		self.p_left = ''
		self.p_right = ''
		self.p_keep = ''

	def train(self, data, labels):
		"""
		Trains the classifier with N data points and labels.

		INPUTS
		data - array of N observations
		  - Each observation is a tuple with 4 values: s, d, 
		    s_dot and d_dot.
		  - Example : [
			  	[3.5, 0.1, 5.9, -0.02],
			  	[8.0, -0.3, 3.0, 2.2],
			  	...
		  	]

		labels - array of N labels
		  - Each label is one of "left", "keep", or "right".
		"""
		data = pd.DataFrame(data)
		labels = pd.DataFrame(labels)
		combined = data.merge(labels, left_index= True, right_index = True)
		# print(combined.head(3))
		combined.columns = ['A','B','C','D','label']
		# Number of left
		n_left = combined['label'][combined['label'] == 'left'].count()
		n_right = combined['label'][combined['label'] == 'right'].count()
		n_keep = combined['label'][combined['label'] == 'keep'].count()

		# Total rows
		total = combined['label'].count()

		self.p_left = n_left / total
		self.p_right = n_right / total
		self.p_keep = n_keep / total

		# print(n_left,n_keep,n_right,total)

		# Group the data by label and calculate the means of each feature
		self.data_means = combined.groupby('label').mean()


		# Group the data by label and calculate the variance of each feature
		self.data_variance = combined.groupby('label').var()

		# View the values
		# print(self.data_variance)

	# Create a function that calculates p(x | y):
	def p_x_given_y(self, x, mean_y, variance_y):
		# Input the arguments into a probability density function
		p = 1 / (np.sqrt(2 * np.pi * variance_y)) * np.exp((-(x - mean_y) ** 2) / (2 * variance_y))

		# return p
		return p


	def predict(self, observation):
		"""
		Once trained, this method is called and expected to return 
		a predicted behavior for the given observation.

		INPUTS

		observation - a 4 tuple with s, d, s_dot, d_dot.
		  - Example: [3.5, 0.1, 8.5, -0.2]

		OUTPUT

		A label representing the best guess of the classifier. Can
		be one of "left", "keep" or "right".
		"""
		cols = ['A','B','C','D']
		# for i in range(len(observation)):
		val_keep = self.p_keep*\
				   self.p_x_given_y(observation[0], self.data_means['A']['keep'], self.data_variance['A']['keep'])*\
				   self.p_x_given_y(observation[1], self.data_means['B']['keep'], self.data_variance['B']['keep'])*\
				   self.p_x_given_y(observation[2], self.data_means['C']['keep'], self.data_variance['C']['keep'])*\
				   self.p_x_given_y(observation[3], self.data_means['D']['keep'], self.data_variance['D']['keep'])

		val_left = self.p_left * \
				   self.p_x_given_y(observation[0], self.data_means['A']['left'], self.data_variance['A']['left']) * \
				   self.p_x_given_y(observation[1], self.data_means['B']['left'], self.data_variance['B']['left']) * \
				   self.p_x_given_y(observation[2], self.data_means['C']['left'], self.data_variance['C']['left']) * \
				   self.p_x_given_y(observation[3], self.data_means['D']['left'], self.data_variance['D']['left'])

		val_right = self.p_right * \
				   self.p_x_given_y(observation[0], self.data_means['A']['right'], self.data_variance['A']['right']) * \
				   self.p_x_given_y(observation[1], self.data_means['B']['right'], self.data_variance['B']['right']) * \
				   self.p_x_given_y(observation[2], self.data_means['C']['right'], self.data_variance['C']['right']) * \
				   self.p_x_given_y(observation[3], self.data_means['D']['right'], self.data_variance['D']['right'])

		if val_keep >= val_left and val_keep >= val_right:
			return 'keep'
		elif val_left >= val_keep and val_left >= val_right:
			return 'left'
		elif val_right >= val_keep and val_right >= val_left:
			return 'right'
		else:
			return '-1'


