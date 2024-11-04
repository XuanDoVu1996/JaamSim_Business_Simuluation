# PROJECT 2 - QUESTION 1

# A. Main model configurations
set Customers; # set of buildings / customers
set Locations; # set of potential truck locations

param d{Customers} >= 0; # demand for customer i
param c{Customers, Locations} >= 0; # travel distance from customer i to location j
param a{Customers, Locations}; # demand multiplier for customer i and location j
param f >= 0; # fixed cost for placing a truck at a location
param r >= 0; # revenue per burrito sold
param k >= 0; # ingredient cost per burrito sold
param truck_number >=0; # maximum numbers of truck

var x{Locations} binary; # =1 if a truck is located at location j, 0 otherwise
var y{Customers, Locations} binary; # =1 if the closest truck to customer i is at location j, 0 otherwise

maximize Total_profit:
	sum{i in Customers, j in Locations}((r-k)*round(a[i,j]*d[i])*y[i,j]) 
	- sum{j in Locations}(f*x[j]); 

subject to
closet_truck{i in Customers}: # maximum one closest truck
	sum{j in Locations}y[i,j] <= 1;
	
relation_1{i in Customers, j in Locations}: # no truck then no closest
	y[i,j] <= x[j];

max_truck{i in Customers}: # maximum number of trucks
	sum{j in Locations}x[j] = truck_number;


# --------------------------------------------------------------------------
# B. Additional variables/KPIs to display	
var Total_revenue;
var Total_expense;

var Total_sales; 				
var Sales_per_building{Customers};
var Sales_per_truck{Locations};
var Sales{Customers, Locations} ; 	# sales per truck per building


