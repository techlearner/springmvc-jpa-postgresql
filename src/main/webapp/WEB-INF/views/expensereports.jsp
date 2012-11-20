<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="http://jzaefferer.github.com/jquery-validation/jquery.validate.js"></script>
    <script src="<c:url value="/resources/javascript/expensereport.js" />"></script>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
</head>
<body>
 <!--<script language="javascript" type="text/javascript">
   
    $(function () {
        utils.setup('${pageContext.request.contextPath}');
    });

    //
</script>-->
   <div id="contentWrapper">
    <div class="blue-b">
    <div class="inside-nav">
        <div class="logo">
            <img src="<c:url value="/resources/images/logo.png" />" />
        </div>
            <ul class="nav-a">
            <li>
            <a href="#">Hi ${user.userName}</a> 
            </li>
            <li>
            |
            </li>
            <li>
            <a href="<c:url value="/j_spring_security_logout" />">Logout</a>
            </li>
            </ul>
      </div>
 </div>
 
 <div id="nav">
	<ul>
	 <li>
			<a id="myExpenseTab" class="tabLinks" href="#" data-tab="myExpenseContainer">My Expenses</a>
	</li>
	<li>
			<a  class="tabLinks" href="#" data-tab="newExpenseContainer">New Expense</a>
   </li>
	<c:if test="${user.role.roleName eq 'ROLE_MANAGER'}">
	<li>
	       <a id="approvalTab" href="#" class="tabLinks" data-tab="approvalsContainer">Approvals</a>
	</li>
	</c:if>
	</ul>
</div>
 
<!--  <div ng-controller="ExpenseCtrl">
    <div style=" z-index: -21; float: left;padding-top :10px; padding:10px;min-width: 250px;max-width:300px;  ">
        <form class="well form-search" ng-submit="search()">
                <div>
                    <input type="text" id="search" placeholder="Search By Expense Id" class="input-medium search-query" ng-model="query"/>
                    <a href="#" class="icon-search" ng-click="search()"></a>
                </div>
                <div style="padding-top: 10px;">
                    <div ng-show=" !searchResultsFound()">
                        <span class="no-records">(no results)</span>
                    </div>
                    <!-- <div ng-show=" searchResultsFound()">
                        <div ng-repeat="expense in expenses" class="search-results">
                            <span class="title">
                                <span style="font-size: smaller"><span>#</span>{{expense.id}}</span>
                                <a ng-click="load(expense)">{{expense.id}}</a> </span>
                        </div>
                    </div>
                </div>
            </form>
    </div>

    <form class="form-horizontal" ng-submit="updateExpense">
        <fieldset>
            <legend>
                <span class="expense-visible-{{!isExpenseLoaded()}}"> Create New Expense </span>
                <span class="expense-visible-{{isExpenseLoaded()}}"> Update or Delete Expense - {{expense.id}} </span>
            </legend>
            <!--  <div class="control-group">
                <label class="control-label" for="description">Description:</label>

                <div class="controls">
                    <input class="input-xlarge" id="description" type="text" ng-model="expense.description"
                           placeholder="Description" required="required"/>

                    <span class="expense-visible-{{isExpenseLoaded()}}"><p class="help-block">Change the description</p></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="amount">Amount</label>

                <div class="controls">
                    <input class="input-xlarge" id="amount" ng-model="expense.amount" placeholder="Amount"
                           required="required" type="number" step="any"/>

                    <span class="expense-visible-{{isExpenseLoaded()}}"><p class="help-block">Change the Amount</p></span>
                </div>
            </div>
            
            <!--  <div class="control-group">
                <label class="control-label" for="file">Attachment</label>

                <div class="controls">                   
                    <a class="label-7 flt-right" href="#" id="attachment-holder"><img
                     class="clip-a-img"
                     src="<c:url value="/resources/images/clip-a.png" />"><span
                     id="attachment-name">Attach Receipt</span> </a> <input id="file"
                     name="file" style="display: none;" type="file" ng-model="expense.attachment.fileNmae">

                    <p class="help-block">Change the Attachment</p>
                </div>
            </div> -->
            
            <!-- <div class="control-group">
              <label class="control-label" for="expenseTypeId">ExpenseType</label>
              
              <div class="controls">
                  <select id="expenseTypeId" name="expenseTypeId"
                    ng-model="expense.expenseType.id" required="required">
                  <option value=""></option>
                  <c:forEach var="expenseType" items="${expenseTypeList}">
                    <option value="${expenseType.id}">${expenseType.name}
                    </option>
                 </c:forEach>
                 </select> -->
                 
                 <!-- <span class="expense-visible-{{isExpenseLoaded()}}"><p class="help-block">Change the ExpenseType</p></span>
              </div>
            
            </div>

            <div class="form-actions">
              <span class="expense-visible-{{!isExpenseLoaded()}}">
                <button type="submit" class="btn btn-primary" ng-click="save()" ng-model-instant>
                    <a class="icon-plus"></a> Save
                </button>
              </span>
              <span class="expense-visible-{{isExpenseLoaded()}}">
                <button type="submit" class="btn btn-primary" ng-click="save()" ng-model-instant>
                    <a class="icon-plus"></a> Update
                </button>
               </span>
                
                <button class="btn btn-primary" ng-click="trash()"><a class="icon-trash"></a> Cancel</button>
                <button class="btn btn-primary" ng-click="deleteexpense()"><a><img class="cross-b-img" src="<c:url value="/resources/images/cross-b.png" />" >Delete</a></button>
            </div>
        </fieldset> -->
        
      <div class = "masterContainer">  
        <div id="newExpenseContainer" class="mc-a tabContainer">
            <br><br><br>
            <input type="hidden" id="expenseload" value="" />
			<c:if test="${empty expenseload}"><h2 class="header label-2 mbot20"> Adding new expense </h2></c:if>
			<c:if test="${not empty expenseload}"><h2 class="header label-2 mbot20"> Editing an expense </h2></c:if>
			<div class="action-a">
			<label class="label-name" for="expense_description">Description</label>
			<textarea class="textbox-a" placeholder="description" required="required"></textarea>
			</div>
			<input type="hidden" id="expenseload" value="" />
			<div class="action-a">
			<label class="label-name" for="expense_amount">Amount</label>
			 <input class="textbox-a dd-b flt-left mleft0" id="amount" name="amount" required="required" placeholder="Amount" size="30" type="text">
			</div>
		    <div class="action-a">
		    <label class="label-name" for="expenseTypeId">Expense Type</label>
				<div class="textbox-a dd-a mleft0">
					<select id="expenseTypeId" name="expenseTypeId"  required="required" >
                      <option value=""></option>
                       <c:forEach var="expenseType" items="${expenseTypeList}">
                         <option value="${expenseType.id}">${expenseType.name}</option>
                       </c:forEach>
                    </select>
				</div>
			 </div>
			<c:if test="${empty expenseload}"><button class="btn-a add-expense-btn">ADD EXPENSE</button></c:if>
			<c:if test="${not empty expenseload}"><button class="btn-a edit-expense-btn">UPDATE EXPENSE</button></c:if>
		</div>
		
		<div id="myExpenseContainer" class="myexpense tabContainer active">
		    <table  id="expenseTable" class="table-a mtop80">
				<thead>
					<tr>
					<td class="td-a">
						<h5 class="label-3">Expense Id </h5>
					</td>
						<td class="td-b">
							<h5 class="label-3">Date </h5>
						</td>
						<td  class="td-c">
							<h5 class="label-3">Expense Type </h5>
						</td>
						<td  class="td-d">
							<h5 class="label-3">Description </h5>
						</td>
						<td  class="td-d">
							<h5 class="label-3">Status </h5>
						</td>
					</tr>
				</thead>
				<tbody></tbody>
				</table>
		
		     </div>
		     
		     <div id="approvalsContainer" class="approvalExpense tabContainer">
		     <table id="approvalTable" class="table-a mtop80">
					<thead>
						<tr>
							<td class="td-a">
								<h5 class="label-3">
									Date<i class="bg-arrow-down-a"><img
										src="<c:url value="/resources/images/arrow-down-a.png"/>"></i>
								</h5>
							</td>
							<td class="td-b">
								<h5 class="label-3">Expense ID</h5>
							</td>
							<td class="td-c">
								<h5 class="label-3">Description</h5>
							</td>
							<td class="td-d">
								<h5 class="label-3">Status</h5>
							</td>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
		       </div>
		</div>
        
  <!--   </form>
    
    <div align="center" ng-repeat="expense in expenses" class="search-results">
        <table>
               <tr><td>             <span class="title">
                                <span style="font-size: 100%"><span>#</span>Expense Report &nbsp;&nbsp;&nbsp;</span></td>
                                <td><a ng-click="load(expense)">{{expense.id}}</a> </span></td>
               </tr>
        </table>
     </div>
</div> -->
</div>
</body>
</html>