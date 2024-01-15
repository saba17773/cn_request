<?php

namespace Controllers;
use Components\Authentication as A;

class Welcome
{
	public function login()
	{
		renderView("page/Login");
	}
	public function index()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/welcome");
	}
	public function createdebit()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/create-debit");
	}
	public function updatedebit()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/update-debit");
	}
	public function user()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/user-master");
	}
	public function customer()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/customer-master");
	}
	public function company()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/company-master");
	}
	public function department()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/department-master");
	}
	public function subject()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/subject-master");
	}
	public function currency()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/currency-master");
	}
	public function profile()
	{
		if (A::isLogin() === false) {
			renderView("page/login");
			exit;
		}
		renderView("page/profile");
	}

}