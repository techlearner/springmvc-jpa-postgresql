$(document).ready(function () {
	
   //Tab Nav Links - Handler.
   $("a.tabLinks").on("click", function () {
	   $("div#" + $(this).attr("data-tab")).addClass("active").siblings("div").removeClass("active");	    
   });
	
   //Add Expense - Event Handler declaration.
	$("button.add-expense-btn").on("click", function () {
		   $.post('/html5expense/expenses', {description : $(".textbox-a").val(), expenseTypeId : $("#expenseTypeId").val(), amount : $("input#amount").val()} , function(data) {
		      //$('.result').html(data);
			   $(".textbox-a").val("");
			   $("#expenseTypeId").val("");
			   $("input#amount").val("");
			   $("a[data-tab=myExpenseContainer]").click();
		   });
	});	
	
	//Update an Expense
	$("button.edit-expense-btn").on("click", function () {
		   $.post('/html5expense/expenses/'+$("expenseload").val(), {_method:"PUT", id : $("expenseload").val(), description : $(".textbox-a").val(), expenseTypeId : $("#expenseTypeId").val(), amount : $("input#amount").val()} , function(data) {
		      //$('.result').html(data);
			   $("a[data-tab=myExpenseContainer]").click();
		   });
	});
	
	//Delete an Expense
	$("button.edit-expense-btn").on("click", function () {
		  console.log("delete 1");
		   $.post('/html5expense/expenses/'+$("expenseload").val(), {_method:"DELETE", id : $("expenseload").val(), description : $(".textbox-a").val(), expenseTypeId : $("#expenseTypeId").val(), amount : $("input#amount").val()} , function(data) {
		      //$('.result').html(data);
			   $("a[data-tab=myExpenseContainer]").click();
		   });
	});
	
	//Load My Expenses
	var loadExpenses = function (){
		$.getJSON('/html5expense/expenses', function(jsonResponse) {
			   var expenseList = "";
			   $.each(jsonResponse, function () {
			      var self = this;
			      expenseList += '<tr><td>'+ self.id +'</td> <td> <h5 class="label-4">' + new Date(parseInt(self.expenseDate)) +
			      '</h5></td><td> <h5 class="label-4">' + self.expenseType.name + '</h5></td><td><h5 class="label-4">' +
			      self.description + '</h5></td><td><h5 class="label-4"><i class="alt-a label-5 blue"><img class="right-a-img" src="/html5expense/resources/images/question-a.png ">' + 
			      self.state +'</i><i class="alt-b label-6"><img class="question-a-img" src="/html5expense/resources/images/question-a.png" >' + 
			      self.state + '<a href="#" id=' + self.id + ' class="bg-edit-b"> <img class="clip-b-img" src="/html5expense/resources/images/edit-a.png"> </a>'+
			      '<a href="#" id=' + self.id + ' class="bg-cross-b"><img class="cross-b-img" src="/html5expense/resources/images/cross-b.png"> </a></i></h5></td></tr>"';    
			    });
			  $("table#expenseTable tbody","div.myexpense").html(expenseList);
			});  	
	};
	
	//Load pending expenses

	var loadApprovalPendingExpenses = function (){
		$.getJSON('/html5expense/expenses/approvals', function(jsonResponse) {
			   var expenseList = "";
			   $.each(jsonResponse, function () {
			      var self = this;
			      expenseList += '<tr><td><h5 class="label-4">' + self.expenseDate + '</h5></td><td> <h5 class="label-4">' + self.id + '</h5></td><td><h5 class="label-4">' + self.description + '</h5></td><td><select id="action_1" class="test" name="1" style="font-size: 11px;height: 25px;width: 120px;"><option selected="selected" value="Pending">PENDING</option><option value="APPROVED">Approve</option><option value="REJECTED">Reject</option></select></td></tr>"';    
			    });
			  $("table#approvalTable tbody","div.approvalExpense").html(expenseList);
			});  	
	};
	
	
	//Retrieve user expenses.
	$("a#myExpenseTab").on("click", loadExpenses);
	
	//Retrieve pending expenses
	$("a#approvalTab").on("click", loadApprovalPendingExpenses);
	
	$("img#clip-b-img").on("click", function(){
		$.getJSON('/html5expense/expenses', function(jsonResponse) {
		});
	});
	
	//On change the status of the expense action_1
	$("select.test").change(function (){
		console.log("change state url "+'/html5expense/expenses/'+self.attr('id')+'/changestate/'+$("select option:selected").val());
		$.getJSON('/html5expense/expenses/'+self.attr('id')+'/changestate/'+$("select option:selected").val(), function(jsonResponse) {
			$("a[data-tab=approvalsContainer]").click();
			});
		
	});
	
	
	var utils = {
		    _url:'',
		    setup:function (u) {
		        this._url = u;
		    },
		    url:function (u) {
		        return this._url + u;
		    },
		    
		    put:function (url, data, cb) {
		        var k = '_method',
		            v = 'PUT';
		        data[k] = v;
		        var headers = {};
		        headers[k] = v;
		        $.ajax({
		            type:'POST',
		            url:url,
		            cache:false,
		            headers:headers,
		            data:data,
		            success:function (result) {
		            	console.log("result is"+result);
		                cb(result);
		                console.log("Successful created ");
		            },
		            error:function (e) {
		                console.log('error PUT\'ing to url ' + url + '. ' + JSON.stringify(e));
		            }
		        });
		    },
		    delet:function (url, data, cb) {
		        var k = '_method',
		            v = 'DELETE';
		        data[k] = v;
		        var headers = {};
		        headers[k] = v;
		        $.ajax({
		            type:'POST',
		            url:url,
		            cache:false,
		            headers:headers,
		            data:data,
		            success:cb,
		            error:function (e) {
		                console.log('error DELET\'ing this url ' + url + '. ' + JSON.stringify(e));
		            }
		        });
		    }
		};
	
	//Edit Expense - Event handler.
	$("table#expenseTable").on("click","a.bg-edit-b", function(evt){
		   evt.preventDefault();
		   //console.log("url is "+'/html5expense/expenses/'+self.attr('id'));
		   var self = $(this);
				$.getJSON('/html5expense/expenses/'+self.attr('id'), function(jsonResponse) {
					$(".textbox-a").val(jsonResponse.description);
					$("#expenseTypeId").val(jsonResponse.expenseType.id);
					$("input#amount").val(jsonResponse.amount);
					$("input#expenseload").val(jsonResponse.id);
					console.log("expenseload value "+$("input#expenseload").val());
					$("a[data-tab=newExpenseContainer]").click();
				});
    });
	
	//Delete Expense - Event handler.
	$("table#expenseTable").on("click","a.bg-cross-b", function(evt){
		   evt.preventDefault();
		   var self = $(this);
		   console.log("delete 2 url"+'/html5expense/expenses/'+self.attr('id')+'/');
            utils.delet('/html5expense/expenses/'+self.attr('id')+'/', {}, function() {
				$("a[data-tab=myExpenseContainer]").click();
			});	   
    });
	loadExpenses();  //on load to show user my expenses
});

