#include <ATen/Context.h>
#include <ATen/cuda/CUDAContext.h>
#include <ATen/Dispatch.h>
#include <ATen/NativeFunctions.h>
#include <ATen/cuda/PinnedMemoryAllocator.h>
#include <ATen/cuda/CUDAApplyUtils.cuh>
#include <ATen/cuda/detail/IndexUtils.cuh>

#include <ATen/native/LinearAlgebraUtils.h>
#include <ATen/native/cuda/MiscUtils.h>

#include <THC/THC.h> // for USE_MAGMA

#ifdef USE_MAGMA
#include <magma.h>
#include <magma_types.h>
#endif

namespace at {
namespace native {

#ifdef USE_MAGMA
template<class scalar_t>
void magmaSolve(
    magma_int_t n, magma_int_t nrhs, scalar_t* dA, magma_int_t ldda,
    magma_int_t* ipiv, scalar_t* dB, magma_int_t lddb, magma_int_t* info) {
  AT_ERROR("solve only takes float or double Tensors");
}

template<class scalar_t>
void magmaSolveBatched(
    magma_int_t n, magma_int_t nrhs, scalar_t** dA_array, magma_int_t ldda,
    magma_int_t** dipiv_array, scalar_t** dB_array, magma_int_t lddb,
    magma_int_t* dinfo_array, magma_int_t batch_count, const MAGMAQueue& magma_queue) {
  AT_ERROR("solve only takes float or double Tensors");
}

template<class scalar_t>
void magmaLu(
    magma_int_t m, magma_int_t n, scalar_t* dA, magma_int_t ldda,
    magma_int_t* ipiv, magma_int_t* info) {
  AT_ERROR("lu only takes float or double Tensors");
}

template<class scalar_t>
void magmaLuBatched(
    magma_int_t m, magma_int_t n, scalar_t** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, magma_int_t* info_array, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  AT_ERROR("lu only takes float or double Tensors");
}

template<class scalar_t>
void magmaLuNoPiv(
    magma_int_t m, magma_int_t n, scalar_t* dA, magma_int_t ldda,
    magma_int_t* info) {
  AT_ERROR("lu only takes float or double Tensors");
}

template<class scalar_t>
void magmaLuNoPivBatched(
    magma_int_t m, magma_int_t n, scalar_t** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  AT_ERROR("lu only takes float or double Tensors");
}

template<class scalar_t>
inline magma_int_t magmaGetriOptimalBlocksize(magma_int_t n) {
  AT_ERROR("getri only takes float or double Tensors");
}

template<class scalar_t>
void magmaGetri(
    magma_int_t n, scalar_t* dA, magma_int_t ldda, magma_int_t* ipiv, scalar_t* dwork,
    magma_int_t lwork, magma_int_t* info) {
  AT_ERROR("getri only takes float or double Tensors");
}

template<class scalar_t>
void magmaGetriBatched(
    magma_int_t n, scalar_t** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, scalar_t** dinvA_array, magma_int_t lddia,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  AT_ERROR("getri only takes float or double Tensors");
}

template<class scalar_t>
void magmaCholeskySolve(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, scalar_t* dA, magma_int_t ldda,
    scalar_t* dB, magma_int_t lddb, magma_int_t* info) {
  AT_ERROR("cholesky_solve only takes float or double Tensors");
}

template<class scalar_t>
void magmaCholeskySolveBatched(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, scalar_t** dA_array, magma_int_t ldda,
    scalar_t** dB_array, magma_int_t lddb, magma_int_t& info, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  AT_ERROR("cholesky_solve only takes float or double Tensors");
}

template<class scalar_t>
void magmaCholesky(
    magma_uplo_t uplo, magma_int_t n, scalar_t* dA,
    magma_int_t ldda, magma_int_t* info) {
  AT_ERROR("cholesky only takes float or double Tensors");
}

template<class scalar_t>
void magmaCholeskyBatched(
    magma_uplo_t uplo, magma_int_t n, scalar_t** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  AT_ERROR("cholesky only takes float or double Tensors");
}

template<class scalar_t>
void magmaTriangularSolve(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    scalar_t* dA, magma_int_t ldda, scalar_t* dB, magma_int_t lddb) {
  AT_ERROR("triangular_solve only takes float or double Tensors");
}

template<class scalar_t>
void magmaTriangularSolveBatched(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    scalar_t** dA_array, magma_int_t ldda, scalar_t** dB_array, magma_int_t lddb, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  AT_ERROR("triangular_solve only takes float or double Tensors");
}

template<class scalar_t>
inline magma_int_t magmaGeqrfOptimalBlocksize(magma_int_t m, magma_int_t n) {
  AT_ERROR("geqrf only takes float or double Tensors");
}

template<class scalar_t>
void magmaGeqrf(
    magma_int_t m, magma_int_t n, scalar_t* dA, magma_int_t ldda,
    scalar_t* tau, scalar_t* dT, magma_int_t* info, bool is_v2) {
  AT_ERROR("geqrf only takes float or double Tensors");
}

template<class scalar_t>
void magmaOrgqr(
    magma_int_t m, magma_int_t n, magma_int_t k, scalar_t* dA,
    magma_int_t ldda, scalar_t* tau, scalar_t* dT, magma_int_t nb, magma_int_t* info) {
  AT_ERROR("orgqr only takes float or doule Tensors");
}

template<>
void magmaSolve<double>(
    magma_int_t n, magma_int_t nrhs, double* dA, magma_int_t ldda,
    magma_int_t* ipiv, double* dB, magma_int_t lddb, magma_int_t* info) {
  magma_dgesv_gpu(n, nrhs, dA, ldda, ipiv, dB, lddb, info);
}

template<>
void magmaSolve<float>(
    magma_int_t n, magma_int_t nrhs, float* dA, magma_int_t ldda,
    magma_int_t* ipiv, float* dB, magma_int_t lddb, magma_int_t* info) {
  magma_sgesv_gpu(n, nrhs, dA, ldda, ipiv, dB, lddb, info);
}

template<>
void magmaSolveBatched<double>(
    magma_int_t n, magma_int_t nrhs, double** dA_array, magma_int_t ldda,
    magma_int_t** dipiv_array, double** dB_array, magma_int_t lddb,
    magma_int_t* dinfo_array, magma_int_t batch_count, const MAGMAQueue& magma_queue) {
  magma_dgesv_batched(n, nrhs, dA_array, ldda, dipiv_array, dB_array, lddb, dinfo_array, batch_count, magma_queue.get_queue());
}

template<>
void magmaSolveBatched<float>(
    magma_int_t n, magma_int_t nrhs, float** dA_array, magma_int_t ldda,
    magma_int_t** dipiv_array, float** dB_array, magma_int_t lddb,
    magma_int_t* dinfo_array, magma_int_t batch_count, const MAGMAQueue& magma_queue) {
  magma_sgesv_batched(n, nrhs, dA_array, ldda, dipiv_array, dB_array, lddb, dinfo_array, batch_count, magma_queue.get_queue());
}

template<>
void magmaLu<double>(
    magma_int_t m, magma_int_t n, double* dA, magma_int_t ldda,
    magma_int_t* ipiv, magma_int_t* info) {
  magma_dgetrf_gpu(m, n, dA, ldda, ipiv, info);
}

template<>
void magmaLu<float>(
    magma_int_t m, magma_int_t n, float* dA, magma_int_t ldda,
    magma_int_t* ipiv, magma_int_t* info) {
  magma_sgetrf_gpu(m, n, dA, ldda, ipiv, info);
}

template<>
void magmaLuBatched<double>(
    magma_int_t m, magma_int_t n, double** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, magma_int_t* info_array, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  magma_dgetrf_batched(m, n, dA_array, ldda, ipiv_array, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaLuBatched<float>(
    magma_int_t m, magma_int_t n, float** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, magma_int_t* info_array, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  magma_sgetrf_batched(m, n, dA_array, ldda, ipiv_array, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaLuNoPiv<double>(
    magma_int_t m, magma_int_t n, double* dA, magma_int_t ldda,
    magma_int_t* info) {
  magma_dgetrf_nopiv_gpu(m, n, dA, ldda, info);
}

template<>
void magmaLuNoPiv<float>(
    magma_int_t m, magma_int_t n, float* dA, magma_int_t ldda,
    magma_int_t* info) {
  magma_sgetrf_nopiv_gpu(m, n, dA, ldda, info);
}

template<>
void magmaLuNoPivBatched<double>(
    magma_int_t m, magma_int_t n, double** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_dgetrf_nopiv_batched(m, n, dA_array, ldda, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaLuNoPivBatched<float>(
    magma_int_t m, magma_int_t n, float** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_sgetrf_nopiv_batched(m, n, dA_array, ldda, info_array, batchsize, magma_queue.get_queue());
}

template<>
inline magma_int_t magmaGetriOptimalBlocksize<double>(magma_int_t n) {
  return magma_get_dgetri_nb(n);
}

template<>
inline magma_int_t magmaGetriOptimalBlocksize<float>(magma_int_t n) {
  return magma_get_sgetri_nb(n);
}

template<>
void magmaGetri<double>(
    magma_int_t n, double* dA, magma_int_t ldda, magma_int_t* ipiv, double* dwork,
    magma_int_t lwork, magma_int_t* info) {
  magma_dgetri_gpu(n, dA, ldda, ipiv, dwork, lwork, info);
}

template<>
void magmaGetri<float>(
    magma_int_t n, float* dA, magma_int_t ldda, magma_int_t* ipiv, float* dwork,
    magma_int_t lwork, magma_int_t* info) {
  magma_sgetri_gpu(n, dA, ldda, ipiv, dwork, lwork, info);
}

template<>
void magmaGetriBatched<double>(
    magma_int_t n, double** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, double** dinvA_array, magma_int_t lddia,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_dgetri_outofplace_batched(n, dA_array, ldda, ipiv_array, dinvA_array, lddia, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaGetriBatched<float>(
    magma_int_t n, float** dA_array, magma_int_t ldda,
    magma_int_t** ipiv_array, float** dinvA_array, magma_int_t lddia,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_sgetri_outofplace_batched(n, dA_array, ldda, ipiv_array, dinvA_array, lddia, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaCholeskySolve<double>(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, double* dA, magma_int_t ldda,
    double* dB, magma_int_t lddb, magma_int_t* info) {
  magma_dpotrs_gpu(uplo, n, nrhs, dA, ldda, dB, lddb, info);
}

template<>
void magmaCholeskySolve<float>(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, float* dA, magma_int_t ldda,
    float* dB, magma_int_t lddb, magma_int_t* info) {
  magma_spotrs_gpu(uplo, n, nrhs, dA, ldda, dB, lddb, info);
}

template<>
void magmaCholeskySolveBatched<double>(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, double** dA_array, magma_int_t ldda,
    double** dB_array, magma_int_t lddb, magma_int_t& info, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  info = magma_dpotrs_batched(uplo, n, nrhs, dA_array, ldda, dB_array, lddb, batchsize, magma_queue.get_queue());
}

template<>
void magmaCholeskySolveBatched<float>(
    magma_uplo_t uplo, magma_int_t n, magma_int_t nrhs, float** dA_array, magma_int_t ldda,
    float** dB_array, magma_int_t lddb, magma_int_t& info, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  info = magma_spotrs_batched(uplo, n, nrhs, dA_array, ldda, dB_array, lddb, batchsize, magma_queue.get_queue());
}

template<>
void magmaCholesky<double>(
    magma_uplo_t uplo, magma_int_t n, double* dA,
    magma_int_t ldda, magma_int_t* info) {
  magma_dpotrf_gpu(uplo, n, dA, ldda, info);
}

template<>
void magmaCholesky<float>(
    magma_uplo_t uplo, magma_int_t n, float* dA,
    magma_int_t ldda, magma_int_t* info) {
  magma_spotrf_gpu(uplo, n, dA, ldda, info);
}

template<>
void magmaCholeskyBatched<double>(
    magma_uplo_t uplo, magma_int_t n, double** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_dpotrf_batched(uplo, n, dA_array, ldda, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaCholeskyBatched<float>(
    magma_uplo_t uplo, magma_int_t n, float** dA_array, magma_int_t ldda,
    magma_int_t* info_array, magma_int_t batchsize, const MAGMAQueue& magma_queue) {
  magma_spotrf_batched(uplo, n, dA_array, ldda, info_array, batchsize, magma_queue.get_queue());
}

template<>
void magmaTriangularSolve<double>(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    double* dA, magma_int_t ldda, double* dB, magma_int_t lddb) {
  magma_dtrsm(MagmaLeft, uplo, trans, diag, m, n, 1, dA, ldda, dB, lddb);
}

template<>
void magmaTriangularSolve<float>(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    float* dA, magma_int_t ldda, float* dB, magma_int_t lddb) {
  magma_strsm(MagmaLeft, uplo, trans, diag, m, n, 1, dA, ldda, dB, lddb);
}

template<>
void magmaTriangularSolveBatched<double>(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    double** dA_array, magma_int_t ldda, double** dB_array, magma_int_t lddb, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  magmablas_dtrsm_batched(MagmaLeft, uplo, trans, diag, m, n, 1, dA_array, ldda, dB_array, lddb, batchsize, magma_queue.get_queue());
}

template<>
void magmaTriangularSolveBatched<float>(
    magma_uplo_t uplo, magma_trans_t trans, magma_diag_t diag, magma_int_t m, magma_int_t n,
    float** dA_array, magma_int_t ldda, float** dB_array, magma_int_t lddb, magma_int_t batchsize,
    const MAGMAQueue& magma_queue) {
  magmablas_strsm_batched(MagmaLeft, uplo, trans, diag, m, n, 1, dA_array, ldda, dB_array, lddb, batchsize, magma_queue.get_queue());
}

template<>
inline magma_int_t magmaGeqrfOptimalBlocksize<double>(magma_int_t m, magma_int_t n) {
  return magma_get_dgeqrf_nb(m, n);
}

template<>
inline magma_int_t magmaGeqrfOptimalBlocksize<float>(magma_int_t m, magma_int_t n) {
  return magma_get_sgeqrf_nb(m, n);
}

template<>
void magmaGeqrf<double>(
    magma_int_t m, magma_int_t n, double* dA, magma_int_t ldda,
    double* tau, double* dT, magma_int_t* info, bool is_v2) {
  if (!is_v2) {
    magma_dgeqrf_gpu(m, n, dA, ldda, tau, dT, info);
  } else {
    magma_dgeqrf2_gpu(m, n, dA, ldda, tau, info);
  }
}

template<>
void magmaGeqrf<float>(
    magma_int_t m, magma_int_t n, float* dA, magma_int_t ldda,
    float* tau, float* dT, magma_int_t* info, bool is_v2) {
  if (!is_v2) {
    magma_sgeqrf_gpu(m, n, dA, ldda, tau, dT, info);
  } else {
    magma_sgeqrf2_gpu(m, n, dA, ldda, tau, info);
  }
}

template<>
void magmaOrgqr<double>(
    magma_int_t m, magma_int_t n, magma_int_t k, double* dA, magma_int_t ldda,
    double* tau, double* dT, magma_int_t nb, magma_int_t* info) {
  magma_dorgqr_gpu(m, n, k, dA, ldda, tau, dT, nb, info);
}

template<>
void magmaOrgqr<float>(
    magma_int_t m, magma_int_t n, magma_int_t k, float* dA, magma_int_t ldda,
    float* tau, float* dT, magma_int_t nb, magma_int_t* info) {
  magma_sorgqr_gpu(m, n, k, dA, ldda, tau, dT, nb, info);
}
#endif

#define ALLOCATE_ARRAY(name, type, size, dummy_tensor) \
  auto storage_##name = pin_memory<type>(size, dummy_tensor); \
  name = static_cast<type*>(storage_##name.data());

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ solve ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_solve(Tensor& b, Tensor& A, std::vector<int64_t>& infos) {
#ifndef USE_MAGMA
AT_ERROR("solve: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  auto A_data = A.data<scalar_t>();
  auto b_data = b.data<scalar_t>();
  magma_int_t n = magma_int_cast(A.size(-2), "A.size(-2)");
  magma_int_t nrhs = magma_int_cast(b.size(-1), "b.size(-1)");

  if (b.dim() == 2) {
    auto ipiv = at::empty({n}, at::kInt);
    magma_int_t info = 0;
    magmaSolve<scalar_t>(n, nrhs, A_data, n, ipiv.data<magma_int_t>(),
                        b_data, n, &info);
    infos[0] = info;
  } else {
    auto A_mat_stride = matrixStride(A);
    auto b_mat_stride = matrixStride(b);
    magma_int_t batch_size = magma_int_cast(batchCount(A), "batchCount");

    magma_int_t* info_array;
    magma_int_t* ipiv_data;
    magma_int_t** ipiv_array;
    scalar_t** A_array;
    scalar_t** b_array;

    ALLOCATE_ARRAY(info_array, magma_int_t, batch_size, b);
    ALLOCATE_ARRAY(ipiv_data, magma_int_t, batch_size * n, b);
    ALLOCATE_ARRAY(ipiv_array, magma_int_t*, batch_size, b);
    ALLOCATE_ARRAY(A_array, scalar_t*, batch_size, b);
    ALLOCATE_ARRAY(b_array, scalar_t*, batch_size, b);

    // Set up the created arrays
    for (int64_t i = 0; i < batch_size; i++) {
      A_array[i] = &A_data[i * A_mat_stride];
      b_array[i] = &b_data[i * b_mat_stride];
      ipiv_array[i] = &ipiv_data[i * n];
    }

    MAGMAQueue magma_queue(b.get_device());
    magmaSolveBatched<scalar_t>(
        n, nrhs, A_array, n, ipiv_array, b_array, n,
        info_array, batch_size, magma_queue);

    for (int64_t i = 0; i < batch_size; i++) {
      infos[i] = info_array[i];
    }
  }
#endif
}

std::tuple<Tensor, Tensor> _solve_helper_cuda(const Tensor& self, const Tensor& A) {
  auto self_working_copy = cloneBatchedColumnMajor(self);
  auto A_working_copy = cloneBatchedColumnMajor(A);
  std::vector<int64_t> infos(batchCount(self), 0);
  AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "solve_cuda", [&]{
    apply_solve<scalar_t>(self_working_copy, A_working_copy, infos);
  });
  if (self.dim() > 2) {
    batchCheckErrors(infos, "solve_cuda");
  } else {
    singleCheckErrors(infos[0], "solve_cuda");
  }
  return std::tuple<Tensor, Tensor>(self_working_copy, A_working_copy);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ inverse ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_batched_inverse(Tensor& self, Tensor& self_inv, std::vector<int64_t>& infos) {
#ifndef USE_MAGMA
AT_ERROR("inverse: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  auto self_data = self.data<scalar_t>();
  auto self_mat_stride = matrixStride(self);
  auto self_inv_data = self_inv.data<scalar_t>();
  auto self_inv_mat_stride = matrixStride(self_inv);

  magma_int_t batch_size = magma_int_cast(batchCount(self), "batchCount");
  magma_int_t n = magma_int_cast(self.size(-2), "self.size(-2)");

  magma_int_t* info_array;
  magma_int_t* ipiv_data;
  magma_int_t** ipiv_array;
  scalar_t** self_array;
  scalar_t** self_inv_array;

  ALLOCATE_ARRAY(info_array, magma_int_t, batch_size, self);
  ALLOCATE_ARRAY(ipiv_data, magma_int_t, batch_size * n, self);
  ALLOCATE_ARRAY(ipiv_array, magma_int_t*, batch_size, self);
  ALLOCATE_ARRAY(self_array, scalar_t*, batch_size, self);
  ALLOCATE_ARRAY(self_inv_array, scalar_t*, batch_size, self_inv);

  // Set up the created arrays
  for (int64_t i = 0; i < batch_size; i++) {
    self_array[i] = &self_data[i * self_mat_stride];
    self_inv_array[i] = &self_inv_data[i * self_inv_mat_stride];
    ipiv_array[i] = &ipiv_data[i * n];
  }

  MAGMAQueue magma_queue(self.get_device());
  magmaLuBatched<scalar_t>(
    n, n, self_array, n, ipiv_array, info_array,
    batch_size, magma_queue);

  magmaGetriBatched<scalar_t>(
    n, self_array, n, ipiv_array, self_inv_array,
    n, info_array, batch_size, magma_queue);

  for (int64_t i = 0; i < batch_size; i++) {
    infos[i] = info_array[i];
  }
#endif
}

template <typename scalar_t>
static void apply_single_inverse(Tensor& self, int64_t& info) {
#ifndef USE_MAGMA
AT_ERROR("inverse: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  auto self_data = self.data<scalar_t>();
  magma_int_t n = magma_int_cast(self.size(-2), "self.size(-2)");
  magma_int_t lwork = n * magmaGetriOptimalBlocksize<scalar_t>(n);
  magma_int_t info_tmp = 0;

  Tensor ipiv = at::empty({n}, at::kInt);
  Tensor dwork = at::empty({lwork}, self.options());
  magmaLu<scalar_t>(n, n, self_data, n, ipiv.data<magma_int_t>(), &info_tmp);
  if (info_tmp != 0) {
    info = info_tmp;
    return;
  }
  magmaGetri<scalar_t>(
    n, self_data, n, ipiv.data<magma_int_t>(), dwork.data<scalar_t>(), lwork, &info_tmp);
  info = info_tmp;
#endif
}

Tensor _inverse_helper_cuda(const Tensor& self) {
  auto self_inv_working_copy = cloneBatchedColumnMajor(self);
  if (self.dim() > 2) {
    std::vector<int64_t> infos(batchCount(self), 0);
    auto self_working_copy = cloneBatchedColumnMajor(self);
    AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "inverse_cuda", [&]{
      apply_batched_inverse<scalar_t>(
        self_working_copy, self_inv_working_copy, infos);
    });
    batchCheckErrors(infos, "inverse_cuda");
  } else {
    int64_t info = 0;
    AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "inverse_cuda", [&]{
      apply_single_inverse<scalar_t>(self_inv_working_copy, info);
    });
    singleCheckErrors(info, "inverse_cuda");
  }
  return self_inv_working_copy;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cholesky_solve ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_cholesky_solve(Tensor& b, Tensor& A, bool upper, int64_t& info) {
#ifndef USE_MAGMA
AT_ERROR("cholesky_solve: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  magma_uplo_t uplo = upper ? MagmaUpper : MagmaLower;

  auto A_data = A.data<scalar_t>();
  auto b_data = b.data<scalar_t>();
  magma_int_t n = magma_int_cast(A.size(-2), "A.size(-2)");
  magma_int_t nrhs = magma_int_cast(b.size(-1), "b.size(-1)");

  int info_tmp;
  if (b.dim() == 2) {
    magmaCholeskySolve<scalar_t>(uplo, n, nrhs, A_data, n,
                                 b_data, n, &info_tmp);
    info = info_tmp;
  } else {
    auto A_mat_stride = matrixStride(A);
    auto b_mat_stride = matrixStride(b);
    magma_int_t batch_size = magma_int_cast(batchCount(A), "batchCount");

    scalar_t** A_array;
    scalar_t** b_array;

    ALLOCATE_ARRAY(A_array, scalar_t*, batch_size, b);
    ALLOCATE_ARRAY(b_array, scalar_t*, batch_size, b);

    // Set up the created arrays
    for (int64_t i = 0; i < batch_size; i++) {
      A_array[i] = &A_data[i * A_mat_stride];
      b_array[i] = &b_data[i * b_mat_stride];
    }

    MAGMAQueue magma_queue(b.get_device());
    magmaCholeskySolveBatched<scalar_t>(
        uplo, n, nrhs, A_array, n, b_array, n,
        info_tmp, batch_size, magma_queue);

    info = info_tmp;
  }
#endif
}

Tensor _cholesky_solve_helper_cuda(const Tensor& self, const Tensor& A, bool upper) {
  int64_t info = 0;
  auto self_working_copy = cloneBatchedColumnMajor(self);
  auto A_working_copy = cloneBatchedColumnMajor(A);
  AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "cholesky_solve_cuda", [&]{
    apply_cholesky_solve<scalar_t>(self_working_copy, A_working_copy, upper, info);
  });
  TORCH_CHECK(info == 0, "MAGMA cholesky_solve : invalid argument: ", -info);
  return self_working_copy;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cholesky ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_cholesky(Tensor& self, bool upper, std::vector<int64_t>& infos) {
#ifndef USE_MAGMA
AT_ERROR("cholesky: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  magma_uplo_t uplo = upper ? MagmaUpper : MagmaLower;

  auto self_data = self.data<scalar_t>();
  magma_int_t n = magma_int_cast(self.size(-2), "self.size(-2)");

  if (self.dim() == 2) {
    magma_int_t info = 0;
    magmaCholesky<scalar_t>(uplo, n, self_data, n, &info);
    infos[0] = info;
  } else {
    auto self_mat_stride = matrixStride(self);
    magma_int_t batch_size = magma_int_cast(batchCount(self), "batchCount");

    magma_int_t* info_array;
    scalar_t** self_array;

    ALLOCATE_ARRAY(info_array, magma_int_t, batch_size, self);
    ALLOCATE_ARRAY(self_array, scalar_t*, batch_size, self);

    // Set up the created arrays
    for (int64_t i = 0; i < batch_size; i++) {
      self_array[i] = &self_data[i * self_mat_stride];
    }

    MAGMAQueue magma_queue(self.get_device());
    magmaCholeskyBatched<scalar_t>(
      uplo, n, self_array, n, info_array,
      batch_size, magma_queue);

    for (int64_t i = 0; i < batch_size; i++) {
      infos[i] = info_array[i];
    }
  }
#endif
}

Tensor _cholesky_helper_cuda(const Tensor& self, bool upper) {
  std::vector<int64_t> infos(batchCount(self), 0);
  Tensor self_working_copy;
  if (upper) {
    self_working_copy = cloneBatchedColumnMajor(self.transpose(-1, -2));
  } else {
    self_working_copy = cloneBatchedColumnMajor(self);
  }

  AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "cholesky_cuda", [&]{
    apply_cholesky<scalar_t>(self_working_copy, false, infos);
  });
  if (self.dim() > 2) {
    batchCheckErrors(infos, "cholesky_cuda");
  } else {
    singleCheckErrors(infos[0], "cholesky_cuda");
  }
  if (upper) {
    return self_working_copy.transpose(-1, -2);
  } else {
    return self_working_copy;
  }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ lu ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_lu(Tensor& self, Tensor& pivots, Tensor& infos, bool get_pivots) {
#ifndef USE_MAGMA
AT_ERROR("lu: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  auto self_data = self.data<scalar_t>();
  magma_int_t n = magma_int_cast(self.size(-1), "n");

  if (self.dim() == 2) {
    // If `pivots` is defined, then we have to compute them.
    // We will use the normal getrf function to compute the LU factorization
    // and the pivots
    // We create temporary tensors on the CPU, because tensors on the GPU
    // cause segfault when passed to magmaLu and magmaLuNoPiv. The data is later
    // copied to the appropriate tensors.
    Tensor info_tmp = at::zeros({}, at::kInt);
    if (get_pivots) {
      Tensor piv_tmp = at::empty({n}, at::kInt);
      magmaLu<scalar_t>(
        n, n, self_data, n, piv_tmp.data<magma_int_t>(), info_tmp.data<magma_int_t>());
      pivots.copy_(piv_tmp);
    } else {
      magmaLuNoPiv<scalar_t>(n, n, self_data, n, info_tmp.data<magma_int_t>());
    }
    infos.copy_(info_tmp);
  } else {
    auto self_matrix_stride = matrixStride(self);
    magma_int_t batch_size = magma_int_cast(batchCount(self), "batchCount");

    scalar_t** self_array;
    ALLOCATE_ARRAY(self_array, scalar_t*, batch_size, self);

    // Set up the created arrays
    for (int64_t i = 0; i < batch_size; i++) {
      self_array[i] = &self_data[i * self_matrix_stride];
    }

    MAGMAQueue magma_queue(self.get_device());

    // Same comment as in the case of single matrix above.
    if (get_pivots) {
      auto pivots_data = pivots.data<magma_int_t>();
      auto pivots_matrix_stride = pivots.size(-1);
      magma_int_t** pivots_array;
      ALLOCATE_ARRAY(pivots_array, magma_int_t*, batch_size, pivots);
      for (int64_t i = 0; i < batch_size; i++) {
        pivots_array[i] = &pivots_data[i * pivots_matrix_stride];
      }
      magmaLuBatched<scalar_t>(
        n, n, self_array, n, pivots_array,
        infos.data<magma_int_t>(), batch_size, magma_queue);
    } else {
      magmaLuNoPivBatched<scalar_t>(
        n, n, self_array, n, infos.data<magma_int_t>(),
        batch_size, magma_queue);
    }
  }
#endif
}

std::tuple<Tensor, Tensor, Tensor> _lu_with_info_cuda(const Tensor& self, bool pivot, bool check_errors) {
  TORCH_CHECK(self.dim() >= 2,
           "expected tensor with 2 or more dimensions, got size: ", self.sizes(),
           " instead");
  squareCheckInputs(self);
  auto req_size = self.sizes().vec();
  req_size.pop_back();
  Tensor pivots_tensor = at::zeros(req_size, self.options().dtype(at::kInt));
  req_size.pop_back();
  auto infos_tensor = at::zeros(req_size, self.options().dtype(at::kInt));

  Tensor self_working_copy;
  if (self.numel() == 0) {
    self_working_copy = at::empty_like(self);
  } else {
    self_working_copy = cloneBatchedColumnMajor(self);
    AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "lu_cuda", [&]{
      apply_lu<scalar_t>(self_working_copy, pivots_tensor, infos_tensor, pivot);
    });
  }
  if (check_errors) {
    if (self.dim() == 2) {
      singleCheckErrors(infos_tensor.item<int64_t>(), "lu");
    } else {
      batchCheckErrors(infos_tensor, "lu");
    }
  }
  return std::make_tuple(self_working_copy, pivots_tensor, infos_tensor);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ triu/tril ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t, typename IndexType, bool upper>
#ifdef __HIP_PLATFORM_HCC__
C10_LAUNCH_BOUNDS_1(512)
#endif
__global__
void triu_tril_kernel(
    cuda::detail::TensorInfo<scalar_t, IndexType> result_info,
    const cuda::detail::TensorInfo<scalar_t, IndexType> self_info,
    const int64_t k, const int64_t N) {
  int64_t linear_idx = blockIdx.x * blockDim.x + threadIdx.x;
  if (linear_idx >= N) {
    return;
  }

  auto dims = self_info.dims;

  IndexType self_offset = 0, result_offset = 0;
  // Compute column index and corresponding offset
  IndexType col = linear_idx % self_info.sizes[dims - 1];
  linear_idx /= self_info.sizes[dims - 1];
  self_offset += self_info.strides[dims - 1] * col; 
  result_offset += result_info.strides[dims - 1] * col;

  // Compute row index and corresponding offset
  IndexType row = linear_idx % self_info.sizes[dims - 2];
  linear_idx /= self_info.sizes[dims - 2];
  self_offset += self_info.strides[dims - 2] * row;
  result_offset += result_info.strides[dims - 2] * row;

  // Compute remaining offsets
  IndexType running_index;
  #pragma unroll
  for (IndexType i = dims - 3; i >= 0; --i) {
    running_index = linear_idx % self_info.sizes[i];
    linear_idx /= self_info.sizes[i];
    self_offset += running_index * self_info.strides[i];
    result_offset += running_index * result_info.strides[i];
  }

  bool mask = upper ? (col - row >= k) : (col - row <= k);
  result_info.data[result_offset] = mask ? self_info.data[self_offset] : scalar_t(0);
}

template <bool upper>
Tensor& triu_tril_cuda_template(Tensor& result, const Tensor& self, int64_t k, const char* name) {
  int64_t N = self.numel();
  dim3 dim_block = cuda::getApplyBlock();
  dim3 dim_grid((N + dim_block.x - 1) / dim_block.x);
  AT_DISPATCH_ALL_TYPES_AND(at::ScalarType::Half, self.scalar_type(), name, [&]{
    if (cuda::detail::canUse32BitIndexMath(result) && cuda::detail::canUse32BitIndexMath(self)) {
      auto result_info = cuda::detail::getTensorInfo<scalar_t, int32_t>(result);
      auto self_info = cuda::detail::getTensorInfo<scalar_t, int32_t>(self);
      triu_tril_kernel<scalar_t, int32_t, upper>
        <<<dim_grid, dim_block, 0, at::cuda::getCurrentCUDAStream()>>>(
          result_info, self_info, k, N);
    } else {
      auto result_info = cuda::detail::getTensorInfo<scalar_t, int64_t>(result);
      auto self_info = cuda::detail::getTensorInfo<scalar_t, int64_t>(self);
      triu_tril_kernel<scalar_t, int64_t, upper>
        <<<dim_grid, dim_block, 0, at::cuda::getCurrentCUDAStream()>>>(
          result_info, self_info, k, N);
    }
  });
  AT_CUDA_CHECK(cudaGetLastError());
  return result;
}

Tensor& tril_cuda_(Tensor &self, int64_t k) {
  return tril_cuda_out(self, self, k);
}

Tensor& tril_cuda_out(Tensor &result, const Tensor& self, int64_t k) {
  if (result.sizes() != self.sizes()) {
    result.resize_as_(self);
  }
  if (self.numel() == 0) {
    return result;
  }
  return triu_tril_cuda_template<false>(result, self, k, "tril");
}

Tensor& triu_cuda_(Tensor &self, int64_t k) {
  return triu_cuda_out(self, self, k);
}

Tensor& triu_cuda_out(Tensor &result, const Tensor& self, int64_t k) {
  if (result.sizes() != self.sizes()) {
    result.resize_as_(self);
  }
  if (self.numel() == 0) {
    return result;
  }
  return triu_tril_cuda_template<true>(result, self, k, "triu");
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ triangular_solve ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_triangular_solve(Tensor& b, Tensor& A, bool upper, bool transpose, bool unitriangular) {
#ifndef USE_MAGMA
AT_ERROR("cholesky_solve: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  magma_uplo_t uplo = upper ? MagmaUpper : MagmaLower;
  magma_trans_t trans = transpose ? MagmaTrans : MagmaNoTrans;
  magma_diag_t diag = unitriangular ? MagmaUnit : MagmaNonUnit;

  auto A_data = A.data<scalar_t>();
  auto b_data = b.data<scalar_t>();
  magma_int_t n = magma_int_cast(A.size(-2), "A.size(-2)");
  magma_int_t nrhs = magma_int_cast(b.size(-1), "b.size(-1)");

  if (b.dim() == 2) {
    magmaTriangularSolve<scalar_t>(uplo, trans, diag, n, nrhs, A_data, n, b_data, n);
  } else {
    auto A_mat_stride = matrixStride(A);
    auto b_mat_stride = matrixStride(b);
    magma_int_t batch_size = magma_int_cast(batchCount(A), "batchCount");

    scalar_t** A_array;
    scalar_t** b_array;

    ALLOCATE_ARRAY(A_array, scalar_t*, batch_size, b);
    ALLOCATE_ARRAY(b_array, scalar_t*, batch_size, b);

    // Set up the created arrays
    for (int64_t i = 0; i < batch_size; i++) {
      A_array[i] = &A_data[i * A_mat_stride];
      b_array[i] = &b_data[i * b_mat_stride];
    }

    MAGMAQueue magma_queue(b.get_device());
    magmaTriangularSolveBatched<scalar_t>(
        uplo, trans, diag, n, nrhs, A_array, n,
        b_array, n, batch_size, magma_queue);
  }
#endif
}

std::tuple<Tensor, Tensor> _triangular_solve_helper_cuda(const Tensor& self, const Tensor& A,
                                                         bool upper, bool transpose, bool unitriangular) {
  auto self_working_copy = cloneBatchedColumnMajor(self);
  auto A_working_copy = cloneBatchedColumnMajor(A);
  AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "triangular_solve_cuda", [&]{
    apply_triangular_solve<scalar_t>(self_working_copy, A_working_copy, upper, transpose, unitriangular);
  });
  return std::tuple<Tensor, Tensor>(self_working_copy, A_working_copy);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ qr ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

template <typename scalar_t>
static void apply_qr(Tensor& Q, Tensor& R, int64_t n_columns, std::vector<int64_t>& infos) {
#ifndef USE_MAGMA
AT_ERROR("qr: MAGMA library not found in "
    "compilation. Please rebuild with MAGMA.");
#else
  auto q_data = Q.data<scalar_t>();
  auto r_data = R.data<scalar_t>();
  auto q_matrix_stride = matrixStride(Q);
  auto r_matrix_stride = matrixStride(R);

  magma_int_t m = magma_int_cast(Q.size(-2), "Q.size(-2)");
  magma_int_t n = magma_int_cast(R.size(-1), "R.size(-1)");
  magma_int_t k = m < n ? m : n;
  magma_int_t nb = magmaGeqrfOptimalBlocksize<scalar_t>(m, n);
  int64_t batch_size = batchCount(R);

  Tensor tau = at::empty({k}, Q.options().device(at::kCPU));
  Tensor work = at::empty({(2 * k + magma_roundup(n, 32)) * nb}, R.options());
  scalar_t* tau_data = tau.data<scalar_t>();
  scalar_t* work_data = work.data<scalar_t>();

  // This phase computes R (the raw version)
  // This uses MAGMA's ?geqrf2_gpu function
  magma_int_t info = 0;
  for (int64_t i = 0; i < batch_size; i++) {
    scalar_t* r_working_ptr = &r_data[i * r_matrix_stride];
    magmaGeqrf<scalar_t>(m, n, r_working_ptr, m, tau_data, work_data, &info, /*is_v2=*/true);
    infos[i] = info;
    if (info != 0) {
      return;
    }
  }

  // This phase computes Q (the raw version)
  // We require to perform ?geqrf_gpu again due to this bug in MAGMA:
  // - ?geqrf_gpu allows fast computation of Q via ?orgqr_gpu, but doesn't give R properly.
  // - ?geqrf2_gpu gives correct R, but doesn't allow computation of Q via ?orgqr_gpu
  // Refer to the below link for more details:
  // http://icl.cs.utk.edu/magma/forum/viewtopic.php?f=2&t=1015&p=2800&hilit=geqrf_gpu#p2800
  for (int64_t i = 0; i < batch_size; i++) {
    scalar_t* q_working_ptr = &q_data[i * q_matrix_stride];
    magmaGeqrf<scalar_t>(m, n, q_working_ptr, m, tau_data, work_data, &info, /*is_v2=*/false);
    infos[i] = info;
    if (info != 0) {
      return;
    }
    magmaOrgqr<scalar_t>(m, n_columns, k, q_working_ptr, m, tau_data, work_data, nb, &info);
    infos[i] = info;
    if (info != 0) {
      return;
    }
  }
#endif
}

std::tuple<Tensor,Tensor> _qr_helper_cuda(const Tensor& self, bool some) {
  std::vector<int64_t> infos(batchCount(self), 0);

  // Setup input geometry and inputs for apply_qr
  std::vector<int64_t> q_sizes, q_strides;
  int64_t n_columns_q;
  std::tie(q_sizes, q_strides, n_columns_q) = _compute_geometry_for_Q(self, some);
  Tensor q_working_copy, r_working_copy;

  // If there are no elements, then we simply return a pair of tensors of required dimensions
  if (self.numel() == 0) {
    // Fix the number of columns of q_working_copy appropriately
    q_sizes[self.dim() - 1] = n_columns_q;
    q_working_copy = at::eye(q_sizes[self.dim() - 2], q_sizes[self.dim() - 1], self.options());
    q_working_copy = q_working_copy.expand_as(q_working_copy);

    // We repurpose the same q_sizes for r_working_copy
    // Fix the number of rows and columns of q_working_copy appropriately
    q_sizes[self.dim() - 1] = self.size(-1);
    q_sizes[self.dim() - 2] = n_columns_q;
    r_working_copy = at::empty(q_sizes, self.options());
    return std::make_tuple(q_working_copy, r_working_copy);
  }

  q_working_copy = at::empty_strided(q_sizes, q_strides, self.options());
  q_working_copy.narrow(-1, 0, self.size(-1)).copy_(self);
  r_working_copy = cloneBatchedColumnMajor(self);

  AT_DISPATCH_FLOATING_TYPES(self.scalar_type(), "qr_cuda", [&]{
    apply_qr<scalar_t>(q_working_copy, r_working_copy, n_columns_q, infos);
  });
  if (self.dim() > 2) {
    batchCheckErrors(infos, "qr_cuda");
  } else {
    singleCheckErrors(infos[0], "qr_cuda");
  }

  return std::make_tuple(q_working_copy.narrow_copy(-1, 0, n_columns_q),
                         r_working_copy.narrow_copy(-2, 0, n_columns_q).triu_());
}

}}  // namespace at::native

#undef ALLOCATE_ARRAY
