#include <iostream>
using namespace std;
int main(){
	float discountedPercent,totalPrice,p,finalResult;
	cout<<"enter the total price";
	cin>>totalPrice;
	cout<<"Etner the discounted percent";
	cin>>p;
	discountedPercent = p/100;
	finalResult = discountedPercent * totalPrice;
	cout<<"The discounted price is "<<finalResult;
	cin>>totalPrice;
	
}