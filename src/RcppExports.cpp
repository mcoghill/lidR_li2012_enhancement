// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// C_count_in_disc
IntegerVector C_count_in_disc(NumericVector X, NumericVector Y, NumericVector x, NumericVector y, double radius, int ncpu);
RcppExport SEXP _lidR_li2012enhancement_C_count_in_disc(SEXP XSEXP, SEXP YSEXP, SEXP xSEXP, SEXP ySEXP, SEXP radiusSEXP, SEXP ncpuSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< NumericVector >::type X(XSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type Y(YSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type radius(radiusSEXP);
    Rcpp::traits::input_parameter< int >::type ncpu(ncpuSEXP);
    rcpp_result_gen = Rcpp::wrap(C_count_in_disc(X, Y, x, y, radius, ncpu));
    return rcpp_result_gen;
END_RCPP
}
// C_li2012_auto
IntegerVector C_li2012_auto(S4 las, double dt1, double dt2, NumericVector R, double Zu, double th_tree, double radius);
RcppExport SEXP _lidR_li2012enhancement_C_li2012_auto(SEXP lasSEXP, SEXP dt1SEXP, SEXP dt2SEXP, SEXP RSEXP, SEXP ZuSEXP, SEXP th_treeSEXP, SEXP radiusSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< S4 >::type las(lasSEXP);
    Rcpp::traits::input_parameter< double >::type dt1(dt1SEXP);
    Rcpp::traits::input_parameter< double >::type dt2(dt2SEXP);
    Rcpp::traits::input_parameter< NumericVector >::type R(RSEXP);
    Rcpp::traits::input_parameter< double >::type Zu(ZuSEXP);
    Rcpp::traits::input_parameter< double >::type th_tree(th_treeSEXP);
    Rcpp::traits::input_parameter< double >::type radius(radiusSEXP);
    rcpp_result_gen = Rcpp::wrap(C_li2012_auto(las, dt1, dt2, R, Zu, th_tree, radius));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_lidR_li2012enhancement_C_count_in_disc", (DL_FUNC) &_lidR_li2012enhancement_C_count_in_disc, 6},
    {"_lidR_li2012enhancement_C_li2012_auto", (DL_FUNC) &_lidR_li2012enhancement_C_li2012_auto, 7},
    {NULL, NULL, 0}
};

RcppExport void R_init_lidR_li2012enhancement(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
