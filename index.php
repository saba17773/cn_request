<?php
session_start();
 //define("root", "http://localhost:8895/");
//define("root", "http://lungryn.deestonegrp.com:8818/");
//define("root", "http://192.168.21.166:81/CN_Request_Customize/");
//define("root_path", "/php-starter-master");
require_once "./vendor/autoload.php";
require_once "./bootstrap.php";
require_once('./assets/mpdf/mpdf.php');
use Wattanar\Router;

// edit by wattana
// add another function here!

//Page
Router::get("/", "Controllers\Welcome::index");
Router::get("/user", "Controllers\Welcome::user");
Router::get("/customer", "Controllers\Welcome::customer");
Router::get("/department", "Controllers\Welcome::department");
Router::get("/company", "Controllers\Welcome::company");
Router::get("/subject", "Controllers\Welcome::subject");
Router::get("/currency", "Controllers\Welcome::currency");
Router::get("/createdebit", "Controllers\Welcome::createdebit");
Router::get("/updatedebit", "Controllers\Welcome::updatedebit");
Router::get("/reportdebit", "Controllers\Welcome::reportdebit");
Router::get("/login", "Controllers\Welcome::Login");
Router::get("/profile", "Controllers\Welcome::profile");

//api
Router::get("/api/trans/all", "Controllers\TransController::all");
Router::get("/api/line/all", "Controllers\LineController::all");
Router::get("/api/link/allremark", "Controllers\LineController::allremark");
Router::get("/api/link/allremarktrans", "Controllers\LineController::allremarktrans");
Router::get("/api/user/all", "Controllers\UserController::all");
Router::get("/api/department/all", "Controllers\DepartmentController::all");
Router::get("/api/company/all", "Controllers\CompanyController::all");
Router::get("/api/customer/all", "Controllers\CustomerController::all");
Router::get("/api/customer/allplant", "Controllers\CustomerController::allplant");
Router::get("/api/subject/all", "Controllers\SubjectController::all");
Router::get("/api/subject/alldebit", "Controllers\SubjectController::alldebit");
Router::get("/api/currency/all", "Controllers\CurrencyController::all");
Router::get("/api/type/all", "Controllers\TypeController::all");
Router::get("/api/link/all", "Controllers\LinkController::all");
Router::get("/api/level/all", "Controllers\UserController::alllevel");
Router::get("/api/link/alluserlist", "Controllers\LinkController::alluserlist");
Router::get("/api/trans/deletefile", "Controllers\TransController::deletefile");
Router::get("/api/user/logout", "Controllers\UserController::logout");
Router::post("/api/user/login", "Controllers\UserController::login");

Router::post("/api/customer/sync", "Controllers\CustomerController::sync");
Router::post("/api/department/sync", "Controllers\DepartmentController::sync");

Router::post("/api/trans/approve", "Controllers\TransController::approve");
Router::post("/api/trans/cancel", "Controllers\TransController::cancel");

Router::post("/api/user/create", "Controllers\UserController::create");
Router::post("/api/user/delete", "Controllers\UserController::delete");
Router::post("/api/user/changpassword", "Controllers\UserController::changpassword");
Router::post("/api/subject/create", "Controllers\SubjectController::create");
Router::post("/api/subject/delete", "Controllers\SubjectController::delete");
Router::post("/api/trans/create", "Controllers\TransController::create");
Router::post("/api/trans/update", "Controllers\TransController::update");
Router::post("/api/line/create", "Controllers\LineController::create");
Router::post("/api/line/delete", "Controllers\LineController::delete");
Router::post("/api/currency/create", "Controllers\CurrencyController::create");
Router::post("/api/currency/delete", "Controllers\CurrencyController::delete");
Router::post("/api/line/createremrak", "Controllers\LineController::createremrak");
Router::post("/api/line/deleteremark", "Controllers\LineController::deleteremark");
Router::post("/api/line/deletecheck", "Controllers\LineController::deletecheck");
Router::post("/api/total/deletechecktotal", "Controllers\LineController::deletechecktotal");

Router::get("/api/pdf/reportdebit/([A-Z0-9]+)", "Controllers\ReportController::reportdebit");
Router::get("/api/user/employee", "Controllers\UserController::employee");

Router::run("/CN_Request");
